package com.test.map.vo;

import java.time.LocalTime;

import lombok.Data;

@Data
public class localVO {
	
	private int gid;
	private String lon;
	private String lat;
	private String car_num;
	private String date;
	private String time;
	private String geom;
	private int noise;
	private int rpm;

}
