package com.test.map.mapper;

import java.util.List;


import com.test.map.vo.localVO;
import com.test.map.vo.pointsVO;

public interface TestMapper {
	
	public List<localVO> getCarList ();
	
	public List<pointsVO> getratio (pointsVO vo);

}
