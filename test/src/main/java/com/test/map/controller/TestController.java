package com.test.map.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.map.service.TestService;

import com.test.map.vo.localVO;
import com.test.map.vo.pointsVO;

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
	
	@PostMapping("getRatio")
	@ResponseBody 
	public Map<String, Object> getRatio(@RequestBody pointsVO vo) {

		System.out.println("ratio"+vo.getCar_num());
		
		pointsVO ratio = service.getratio(vo);
		

	    Map<String, Object> map = new HashMap<>();
	    map.put("ratio", ratio);


	    return map;
	}
	
	
}
