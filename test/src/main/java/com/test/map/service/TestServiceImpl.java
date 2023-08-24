package com.test.map.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.map.mapper.TestMapper;
import com.test.map.vo.MapVO;

@Service
public class TestServiceImpl implements TestService {

	@Autowired
	TestMapper mapper;
	
	@Override
	public List<MapVO> getList() {
		return mapper.getList();
	}

}
