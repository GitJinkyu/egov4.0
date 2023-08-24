package com.test.map.mapper;

import java.util.List;

import com.test.map.vo.localVO;
import com.test.map.vo.tempVO;

public interface GPSMapper {
	
	public List<tempVO> getTemp();
	
	public int insertTemp(tempVO vo);
	
	public int deleteTemp();
	
	public int insertLocal(localVO vo);
	
	

}
