package com.test.map.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.map.mapper.TestMapper;
import com.test.map.vo.localVO;
import com.test.map.vo.pointsVO;

@Service
public class TestServiceImpl implements TestService {

	@Autowired
	TestMapper mapper;

	@Override
	public List<localVO> getCarList() {
		return mapper.getCarList();
	}

	@Override
	public pointsVO getratio(pointsVO vo) {
		return mapper.getratio(vo);
	}

	@Override
	public int insertCSV(localVO vo) {
		
		return mapper.insertCSV(vo);
	}

	@Override
	public int insertMultipleCSV(List<localVO> voList) {
		
		return mapper.insertMultipleCSV(voList);
	}


}
