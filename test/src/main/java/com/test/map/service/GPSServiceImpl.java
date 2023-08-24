package com.test.map.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.test.map.mapper.GPSMapper;
import com.test.map.vo.localVO;
import com.test.map.vo.tempVO;

@Service
public class GPSServiceImpl implements GPSService{
	
	@Autowired
	GPSMapper mapper;

	@Override
	public List<tempVO> getTemp() {

		return mapper.getTemp();
	}

	@Override
	public int insertTemp(tempVO vo) {

		return mapper.insertTemp(vo);
	}

	@Override
	public int deleteTemp() {
	
		return mapper.deleteTemp();
	}

	@Override
	public int insertLocal() {
		
		// temp 테이블의 데이터를 조회
        List<tempVO> tempData = getTemp();

        // temp 테이블의 데이터를 local 테이블에 전부 insert
        int insertCount = 0;
        for (tempVO temp : tempData) {
            localVO local = new localVO();
            local.setLon(temp.getLon());
            local.setLat(temp.getLat());
            
            System.out.println("로컬에 넣는중");
            int result = mapper.insertLocal(local);
            if (result == 1) {
                insertCount++;
            }
        }
        
        
        
        return insertCount;
	}
	
    @Scheduled(fixedDelay = 15000) // 60초(1분)마다 실행
    public void transferData() {
        int insertedCount = insertLocal();
        System.out.println("주기적으로 데이터를 옮김. 총 " + insertedCount + "개의 데이터를 옮겼습니다.");
        deleteTemp();
        System.out.println("템프 삭제함");
    }

}
