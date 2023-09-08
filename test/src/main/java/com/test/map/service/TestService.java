package com.test.map.service;

import java.util.List;


import org.springframework.stereotype.Service;

import com.test.map.vo.MemberVO;
import com.test.map.vo.localVO;
import com.test.map.vo.pointsVO;

@Service
public interface TestService {
	
	public List<localVO> getCarList ();
	
	public pointsVO getratio (pointsVO vo);
	
	public int insertCSV(localVO vo);
	
	public int insertMultipleCSV(List<localVO> voList);
	
	public MemberVO login(MemberVO vo);
}
