<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <!-- jquery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- openlayers -->
    <link rel="stylesheet" href="https://openlayers.org/en/v4.6.5/css/ol.css" type="text/css">
    <script src="https://openlayers.org/en/v4.6.5/build/ol.js"></script>
    
    <!-- bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    
    <!-- font awesome -->
    <script src="https://kit.fontawesome.com/63ed9e5411.js" crossorigin="anonymous"></script>

    <style>
        * {
            border: 0;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
    
        .container {
            max-width:1600px;
            margin: 0 atuo;
            padding: 0;
        
        }
    
        .left-container {
            background-color: rgba(212, 212, 212, 0.651);
            text-align: center;
            float: left;
            width: 300px;
            height: 850px;
        }
        
        .right-container {
            float: left;
            width: 1200px;
            height: 850px;
        }
        .button-box{
            height:100%;
        }
        .textbox{
            margin-top:30px;
            text-align: center;
        }
        .visionSelect{
            background-color: white;
            width: 280px;
            height: 80px;
            border-radius: 20px;
            display : flex;
            justify-content: center;
            align-items : center;
            margin: 0 auto;
            margin-bottom: 30px;

        }
        .carSelect{
            background-color: white;
            width: 280px;
            border-radius: 20px;
            justify-content: center;
            align-items : center;
            margin: 0 auto;
            padding-top: 20px;
            padding-bottom: 20px;
            margin-bottom: 30px;


        }
        .dateSelect{
            background-color: white;
            width: 280px;
            border-radius: 20px;
            justify-content: center;
            align-items : center;
            margin: 0 auto;
            padding-top: 20px;
            padding-bottom: 20px;
            display: none;

        }
        
        #datetext{
        text-align: left;
        
        }

        #map{
            height:100%;
        }

        /* .carbtn 버튼의 배경 색상 제거 */
        .carbtn {
            background-color: transparent !important;

        }

        /* #close 버튼의 배경 색상 제거 */
        #close {
            background-color: transparent !important;

        }

        /* .carbtn 버튼의 클릭 스타일 */
        .carbtn:focus {
            border: 1px solid rgb(0, 0, 0); /* 클릭 시 보더 라인 추가 */
        }

        /* #close 버튼의 클릭 스타일 */
        #close:focus {

            border: 1px solid rgb(0, 0, 0); /* 클릭 시 보더 라인 추가 */
        }



    
        
    </style>
    
    <script>
        
        
        
        document.addEventListener("DOMContentLoaded", function() {
            initMap(); // 맵 초기화
              

            // 차량 버튼에 클릭 이벤트 리스너 추가
            var carButtons = document.querySelectorAll(".car-button");
            carButtons.forEach(function(button) {
                button.addEventListener("click", function() {
                    var carNum = button.value;

                    // .dateSelect 섹션 표시 및 내용 업데이트
                    var dateSelectSection = document.querySelector(".dateSelect");
                    dateSelectSection.style.display = "block";
                    
                    var selectedCarNumber = document.getElementById("selectedCarNumber");
                    selectedCarNumber.textContent = carNum;
                });
            });

            // #close 버튼에 클릭 이벤트 리스너 추가
            var closeButton = document.getElementById("close");
            closeButton.addEventListener("click", function() {
                var dateSelectSection = document.querySelector(".dateSelect");
                dateSelectSection.style.display = "none";
            });
        });
        
        var map; // 맵 객체의 전역 변수 선언
        var baseLayer; // 기본 레이어 저장 변수
        var additionalLayers = []; // 추가 레이어 배열
        
        function initMap() {
            // 맵 및 초기 레이어를 초기화합니다.
            var yonginCoords = ol.proj.fromLonLat([127.1775, 37.2410]);
            
            // 기본 레이어 설정
            baseLayer = new ol.layer.Tile({
                source: new ol.source.XYZ({
                    url: 'http://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Base/{z}/{y}/{x}.png'
                })
            });
            
            additionalLayers.push(
                // 추가 레이어 1 (City)
                new ol.layer.Tile({
                    source: new ol.source.TileWMS({
                        url: 'http://localhost:8000/geoserver/test/wms',
                        params: {
                            'LAYERS': 'opengis:emd',
                            'TILED': true,
                        },
                        serverType: 'geoserver',
                    }),
                }),
                // 추가 레이어 2 (LINK)
                new ol.layer.Tile({
                    source: new ol.source.TileWMS({
                        url: 'http://localhost:8000/geoserver/test/wms',
                        params: {
                            'LAYERS': 'opengis:LINK',
                            'TILED': true,
                        },
                        serverType: 'geoserver',
                    }),
                }),
                // 추가 레이어 3 (NODE)
                new ol.layer.Tile({
                    source: new ol.source.TileWMS({
                        url: 'http://localhost:8000/geoserver/test/wms',
                        params: {
                            'LAYERS': 'opengis:NODE',
                            'TILED': true,
                        },
                        serverType: 'geoserver',
                    }),
                })
            );
            
            map = new ol.Map({
                layers: [
                    baseLayer, // 기본 레이어 추가
                    ...additionalLayers // 추가 레이어들 추가
                ],
                target: 'map', // div id map을 선택함
                view: new ol.View({
                    center: yonginCoords,
                    zoom: 11,
                }),
            });
        }
        
        // 레이어 업데이트 함수
        function updateMapLayer(layerSource) {
            baseLayer.setSource(layerSource);
        }
        
        function switchToBasic() {
            updateMapLayer(new ol.source.XYZ({
                url: 'http://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Base/{z}/{y}/{x}.png'
            }));
        }
        
        function switchToSatellite() {
            updateMapLayer(new ol.source.XYZ({
                url: 'http://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Satellite/{z}/{y}/{x}.jpeg'
            }));
        }
        
        var hybridLayer = null; // 하이브리드 레이어 변수
        
        function switchToHybrid() {
            if (hybridLayer) {
                // 하이브리드 레이어가 이미 추가되어 있는 경우, 제거
                map.removeLayer(hybridLayer);
                hybridLayer = null;
            } else {
                // 하이브리드 레이어가 추가되어 있지 않은 경우, 추가
                hybridLayer = new ol.layer.Tile({
                    source: new ol.source.XYZ({
                        url: 'http://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Hybrid/{z}/{y}/{x}.png'
                    })
                });
                map.addLayer(hybridLayer);
            }
        }
       
        
        
      	//get방식 요청
        function fetchGet(url,callback){
        	console.log(url);
        	console.log(callback);
        	
        	try {
        	//url 요청
        	fetch(url)
        		//요청 결과json 문자열을 javascript 객체로 반환
        		.then(response => response.json())
        		//매개로 받은 콜백함수 실행
        		.then(map => callback(map));
        		
        	} catch (e) {
        		console.log(e);
        	}
        	
        	
        }

        //post방식 요청
        function fetchPost(url,obj,callback){
        	console.log(url);
        	console.log(callback);
        	
        	try {
        		//url 요청
        		fetch(url,{method : 'post'
        					,headers : {'Content-Type' : 'application/json'} 
        					,body  : JSON.stringify(obj)
        			  })
        			//요청 결과json 문자열을 javascript 객체로 반환
        			.then(response => response.json())
        			//매개로 받은 콜백함수 실행
        			.then(map => callback(map))	
        		} catch (e) {
        			console.log(e);       		
        		}
        }

        function getRatio(){
        	let car_num = document.querySelector('#selectedCarNumber').textContent;
        	let encodedCarNum = encodeURIComponent(car_num);
        	let date = document.querySelector('#selectDate').value;
	
        	//전달할 객체로 생성
        	let obj = {'car_num' : car_num
        			,  'date' : date
        			}
        	
        	fetchPost('/test/getRatio/',obj,drawRatio)

        }
        
        function drawRatio(fetchmap){
        	let nodata = document.querySelector("#resbox"); 
			
			if(fetchmap.ratio === null){
				
				map.getLayers().clear();
				
				// 기본 레이어 및 추가 레이어들 다시 추가
		        map.addLayer(baseLayer);
		        additionalLayers.forEach(layer => {
		            map.addLayer(layer);
		        });
		        
				nodata.innerHTML = '<p><b>데이터가 없습니다.</b></p>'
				
				
			}else{
	        	let ratio = fetchmap.ratio.ratio;
	        	let time = fetchmap.ratio.time;
	        	
				console.log(ratio)
				console.log(time)
				
				nodata.innerHTML = '';//HTML작성하기전에 한번 초기화해서 백지 만들어주기
				
				nodata.innerHTML += ''
								  +	'<p>운행 시간 : <b>'+time+'</b></p>'
			        			  +	'<p>청소 비율 : <b>'+ratio+'%</b></p>';
				
				
				
				var carNum = document.querySelector('#selectedCarNumber').textContent;
		        var date = document.querySelector('#selectDate').value; 
		        console.log("패치 변수",carNum)
		        console.log("패치 변수",date)
		        
		        
		        var clean_O = new ol.layer.Tile({
		            source: new ol.source.TileWMS({
		                url: 'http://localhost:8000/geoserver/test/wms',
		                params: {
		                    'LAYERS': 'opengis:Clean_O',
		                    'TILED': true,
		                    'VIEWPARAMS': "date:" + date + ";car_num:" + carNum
		                },
		                serverType: 'geoserver',
		            }),
		        });
	
		        var clean_X = new ol.layer.Tile({
		            source: new ol.source.TileWMS({
		                url: 'http://localhost:8000/geoserver/test/wms',
		                params: {
		                    'LAYERS': 'opengis:Clean_X',
		                    'TILED': true,
		                    'VIEWPARAMS': "date:" + date + ";car_num:" + carNum
		                },
		                serverType: 'geoserver',
		            }),
		        });
		        
		        var clean_path = new ol.layer.Tile({
		            source: new ol.source.TileWMS({
		                url: 'http://localhost:8000/geoserver/test/wms',
		                params: {
		                    'LAYERS': 'opengis:Clean_path',
		                    'TILED': true,
		                    'VIEWPARAMS': "date:" + date 
		                },
		                serverType: 'geoserver',
		            }),
		        });
		        
		        
		        
		        
		     	// 맵에 있는 모든 레이어 제거
		        map.getLayers().clear();
	
		        // 기본 레이어 및 추가 레이어들 다시 추가
		        map.addLayer(baseLayer);
		        additionalLayers.forEach(layer => {
		            map.addLayer(layer);
		        });
	
		        // clean_O, clean_X 레이어 맵에 추가
		        map.addLayer(clean_O);
		        map.addLayer(clean_X);
		        map.addLayer(clean_path);
				
				}
		
			
        }


    </script>
</head>
<body>
    <div class="container">
        <div class="left-container">
            
            <div class="button-box">
                
                <div class='textbox'> 
                    <p><img src="https://i.namu.wiki/i/zXavwSCTk_--Z8alXtZ_-SUCyHgMbFJlXA6h-yg9zuS5_RNWDBV4H2Y4nJOESsDLhJcNzwdCSet1w15z1DUmVQ.svg" style='height: 50px; width: 50px;'><b>용인시 청소차 관제 시스템</b></p>
                </div>
                <hr>

                <div class="visionSelect">
                    <i class="fa-solid fa-map-location fa-xl" style="color: #080701; padding-right: 10px;"></i>
                    <div class="btn-group " role="group" aria-label="Basic radio toggle button group" >
                        <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked onclick="switchToBasic()">
                        <label class="btn btn-outline-primary" for="btnradio1">기본</label>
                    
                        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" onclick="switchToSatellite()">
                        <label class="btn btn-outline-primary" for="btnradio2">위성</label>
                    
                        <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off" onclick="switchToHybrid()">
                        <label class="btn btn-outline-primary" for="btncheck3">하이브리드</label>
                    </div>
                </div>
            
            
                <div class="carSelect">
                    <p><b>차량 목록</b></p>
                    <hr>
                    <div id='selectcarlist'>
                    	<c:forEach items="${list}" var="car">
                        <p><i class="fa-solid fa-truck"></i> <button value="${car.car_num}" class="carbtn car-button" id="${car.car_num}">${car.car_num}</button></p>
                    	</c:forEach>  
                    </div>
                </div>
                
                <div class="dateSelect">

				    <p><b><span id="selectedCarNumber"></span></b></p>
				    <hr>
				    <p>
				        <span id="datetext">날짜선택 :</span>
				        <br>
				        <form>
				            <input type="date" id="selectDate">
				            <input type="button" value="확인" id="Datebtn" class="btn btn-outline-primary" onclick="getRatio()">
				        </form>
				    </p>
				    <hr>
				    <div id="resbox">
				        <p>운행 시간 : <b></b></p>
				        <p>청소 비율 : <b></b></p>
				        
				    </div>
				    <hr>
				    <button id="close">접기</button>
				</div>

            </div>
        </div>

        <div class='right-container'>
            <div id="map"></div>
        </div>
    </div>
    
    
    
    
    
</body>
</html>
