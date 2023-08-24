package com.test.map.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.test.map.service.GPSServiceImpl;

@Configuration
@EnableScheduling
public class SchedulingConfig {
	
	 @Autowired
	 GPSServiceImpl gpsServiceImpl;

}
