package com.test.map.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.time.LocalTime;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
	
	
	@PostMapping("insertMultipleCSV")
	@ResponseBody
	public String insertMultipleCSV(@RequestParam("files") MultipartFile[] files) {
	    try {
	        // 각 CSV 파일의 내용을 저장할 리스트 초기화
	        List<String> csvContents = new ArrayList<>();

	        // 업로드된 파일을 순회
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                // 각 CSV 파일의 내용을 읽기
	                try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream(), "EUC-KR"))) {
	                    String line;
	                    while ((line = reader.readLine()) != null) {
	                        csvContents.add(line);
	                    }
	                } catch (IOException e) {
	                    e.printStackTrace();
	                    return "CSV 파일을 읽는 중 오류가 발생했습니다.";
	                }
	            }
	        }

	        // CSV 파일의 첫 번째 행을 필드 이름으로 사용
	        String header = csvContents.get(0);
	        String[] fieldNames = header.split(",");
	        
	        // 이제 모든 CSV 파일의 내용이 `csvContents` 리스트에 저장되었습니다.
	        // 필요한대로 데이터베이스에 병합, 구문 분석 및 삽입할 수 있습니다.

	        // 첫 번째 행은 필드 이름이므로 건너뛰고 나머지 행을 처리합니다.
	        for (int i = 1; i < csvContents.size(); i++) {
	            String[] values = csvContents.get(i).split(",");
	            
	            if (values.length != fieldNames.length) {
	                return "CSV 파일 형식이 올바르지 않습니다.";
	            }
	            
	            localVO vo = new localVO();
	            
	            // 필드 이름과 값을 매핑
	            for (int j = 0; j < fieldNames.length; j++) {
	                String fieldName = fieldNames[j].trim();
	                String value = values[j].trim();
	                
	                switch (fieldName) {
	                    case "lon":
	                        vo.setLon(value);
	                        break;
	                    case "lat":
	                        vo.setLat(value);
	                        break;
	                    case "car_num":
	                        vo.setCar_num(value);
	                        break;
	                    case "date":
	                        vo.setDate(value);
	                        break;
	                    case "time":
	                    	value = "0" + value;
	                        
	                        vo.setTime(LocalTime.parse(value)); // 문자열을 LocalTime으로 파싱
	                        break;
	                    case "noise":
	                        vo.setNoise(value);
	                        break;
	                    case "rpm":
	                        vo.setRpm(value);
	                        break;
	                    default:
	                        // 필드가 추가될 경우에 대비하여 필요한 처리를 추가할 수 있습니다.
	                        break;
	                }
	            }

	            // 이제 vo에는 CSV 행의 데이터가 매핑되었습니다.
	            // 데이터베이스에 삽입 또는 필요한 작업을 수행할 수 있습니다.
	            System.out.println("성공이니?");
	            service.insertCSV(vo);
	        }

	        // 성공 메시지를 반환하거나 오류를 적절하게 처리합니다.
	        System.out.println("성공이니????");
	        return "CSV 파일을 업로드하고 처리했습니다.";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "CSV 파일 처리 중 오류가 발생했습니다.";
	    }
	}




	
	
}
