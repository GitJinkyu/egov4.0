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
	public int insertTemp(tempVO vo) {

		return mapper.insertTemp(vo);
	}

	@Override
	public int deleteTemp() {
	
		return mapper.deleteTemp();
	}

	@Override
	public int insertLocal() {
		
		int res = 0 ;

		res=mapper.insertLocal();
        
        return res;
	}
	
    @Scheduled(fixedDelay = 15000) // 60초(1분)마다 실행
    public void transferData() {
        int res = insertLocal();
        System.out.println("주기적으로 데이터를 옮김. 총 " + res + "개의 데이터를 옮겼습니다.");
        deleteTemp();
        System.out.println("템프 삭제함");
    }

}
