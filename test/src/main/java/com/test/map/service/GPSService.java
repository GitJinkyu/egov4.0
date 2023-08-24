package com.test.map.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.test.map.vo.localVO;
import com.test.map.vo.tempVO;

@Service
public interface GPSService {
	
	public List<tempVO> getTemp();
	
	public int insertTemp(tempVO vo);
	
	public int deleteTemp();
	
	public int insertLocal();

}
