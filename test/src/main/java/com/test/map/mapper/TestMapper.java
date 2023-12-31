package com.test.map.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.test.map.vo.MemberVO;
import com.test.map.vo.localVO;
import com.test.map.vo.pointsVO;

public interface TestMapper {
	
	public List<localVO> getCarList ();
	
	public pointsVO getratio (pointsVO vo);
	
	public int insertCSV (localVO vo);
	
	public int insertMultipleCSV(List<localVO> voList);
	
	public MemberVO login(MemberVO vo);

}
