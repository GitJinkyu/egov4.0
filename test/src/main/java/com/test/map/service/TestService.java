package com.test.map.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.test.map.vo.MapVO;

@Service
public interface TestService {
	public List<MapVO> getList ();
}
