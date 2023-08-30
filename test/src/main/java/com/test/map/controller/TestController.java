package com.test.map.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.test.map.service.TestService;

import com.test.map.vo.localVO;

@Controller
@RequestMapping("/test/*")
public class TestController {
	
	@Autowired
	TestService service;
	
	@GetMapping("map")
	public String getMap(Model model) {
		
		List<localVO> list = service.getCarList();
		
		model.addAttribute("list",list);
		
		return "map";
	}
	
	@GetMapping("gps")
	public String getGps() {
		
		
		
		return "GPS";
	}

}
