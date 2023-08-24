package com.test.map.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import com.test.map.service.GPSService;
import com.test.map.vo.tempVO;



@RestController
@RequestMapping("/GPS/*")
public class GPSController {
	
	@Autowired
	GPSService service;
	
	
	@PostMapping("insert")
	public int insert(@RequestBody tempVO vo) {
		
		
		// 현재 시간, 분, 초 출력
        LocalDateTime currentTime = LocalDateTime.now();
        int hour = currentTime.getHour();
        int minute = currentTime.getMinute();
        int second = currentTime.getSecond();
        
        System.out.println("현재 시간: " + hour + "시 " + minute + "분 " + second + "초");
		
		int res = service.insertTemp(vo);
		
		
		return res;
	}
	

}
