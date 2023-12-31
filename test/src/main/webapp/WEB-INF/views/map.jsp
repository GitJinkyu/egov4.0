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
        
        body {
		    background-color: #333; /* 어두운 회색 배경 색상 */
		    /* 다른 스타일 속성들... */
		}
        
    
        .maincontainer {
        	background-color: white;
            width:1600px;
            height:900px;
            margin: 15px auto;
            

            border-radius: 15px; /* 모서리를 20px 둥글게 만듦 */
            
        }
    
        .left-container {
            float: left;
            width: 20%;
            height: 100%;
            padding: 5px 0 5px 5px; /* 상단, 우측, 하단, 좌측 순서 */
            
        }
        
        .right-container {
            float: left;
            width: 80%;
            height: 100%;
            padding:5px;
            
        }
        
        .ol-unselectable, .ol-viewport {
        	border-radius: 15px; /* 모서리를 20px 둥글게 만듦 */
        
        }
        
        .buttonbox {
        	background-color: rgba(212, 212, 212, 0.651);
            height: 100%;
        	text-align: center;
        	border-radius: 15px; /* 모서리를 20px 둥글게 만듦 */
        	padding: 5px;
        
        }
        
        .textbox{
            margin-top:30px;
            text-align: center;
            
        }
        
        .visionSelect{
            background-color: white;
            width: 280px;
            height: 80px;
            border-radius: 15px;
            display : flex;
            justify-content: center;
            align-items : center;
            margin: 0 auto;
            margin-bottom: 30px;

        }
        
        .carSelect {
		    background-color: white;
		    width: 280px;
		    height: 180px;
		    border-radius: 15px;
		    justify-content: center;
		    align-items: center;
		    margin: 0 auto;
		    padding-top: 20px;
		    padding-bottom: 20px;
		    margin-bottom: 30px;
		    
		    
		}
		
		/* WebKit 브라우저(Chrome, Safari)에서 스크롤바 전체 스타일 지정 */
		#selectcarlist::-webkit-scrollbar {
		    width: 5px; /* 스크롤바 너비 조절 */
	
		}
		
		/* 스크롤바막대 설정 */
		#selectcarlist::-webkit-scrollbar-thumb {
		    background-color: gray;
		    border-radius: 5px; /* 막대를 둥글게 깍음 */ 
		    
		}
        
        #selectcarlist{
            width: 275px;
        	height: 80px;
        	overflow: auto; /* 스크롤바 감추기 */
		
		    /* 스크롤이 필요한 경우 스크롤 스타일 */
		    scrollbar-width: thin;
		    scrollbar-color: transparent transparent;
        
        }
        
        .dateSelect{
            background-color: white;
            width: 280px;
            border-radius: 15px;
            justify-content: center;
            align-items : center;
            margin: 0 auto;
            padding-top: 20px;
            padding-bottom: 20px;
            margin-bottom: 30px;
            display: none;

        }
        
        #datetext{
        	text-align: left;
        
        }

        #map{
            height:100%;
            border-radius: 20px; /* 모서리를 20px 둥글게 만듦 */
            
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


		.uploadbox{
			background-color: white;
            width: 280px;
            height: 60px;
            border-radius: 15px;
            display: flex;
		    flex-direction: column;
		    justify-content: center;
		    align-items: center;
            margin: 0 auto;
            border: 2px dashed #ccc; /* 드래그 앤 드롭 영역을 시각적으로 나타내는 테두리 스타일 */
    		text-align: center; /* 내용 가운데 정렬 */
    		
			
		}
		
		.uploadbox p {
		    margin: 0; /* 기본 마진 제거 */
		}
		
		
/* 모달 스타일 */
.modal {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}

.modal-content {
  background-color: white;
  margin: 15% auto;
  padding: 20px;
  width: 400px;
  height: 300px;
  border-radius: 15px;
  box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
  text-align: center;
}

/* 스타일이 추가된 부분만 표시 */
.modal-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(8px); /* 흐림 효과 */
  z-index: 1040;
  display: none;
}

/* 모달 닫기 버튼 스타일 */
.close {
  float: right;
  cursor: pointer;
  font-size: 24px;
}

.close:hover {
  color: red;
}
		
		
        
    </style>
</head>
<body>
    <div class="maincontainer">
        <div class="left-container">
            
           <div class="buttonbox">
                
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
                    <p><b>차량 목록</b><span style="float: right;">등록</span></p>
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
				
				<div class="uploadbox">
				    <p>파일을 여기로 드래그 앤 드롭하세요.</p>
				</div>

		   </div>

            
        </div>

        <div class='right-container'>
            <div id="map"></div>
        </div>
    </div>
    
<!-- 모달 창 -->
<div id="myModal" class="modal">
  <div class="modal-content">
    <h2>로그인</h2>
    <form id="loginForm">
    <br>
    <div id="msgbox"></div>
    <br>
      <label for="username">ID:</label>
      <input type="text" id="username" name="username">
      <br>
      <label for="password">PW:</label>
      <input type="password" id="password" name="password">
      <br>
      <input type="submit" id="loginbtn" value="로그인">
    </form>
  </div>
</div>

<!-- 모달시 배경 블러 처리용 요소 -->
<div class="modal-backdrop" id="backdrop"></div>
    
    
    <script>
        
        
        
        document.addEventListener("DOMContentLoaded", function() {
            initMap(); // 맵 초기화
            
         	// 세션에서 loggedInMember 가져오기
            var loggedInMember = '<%= session.getAttribute("loggedInMember") %>';
			console.log("세션? = =",loggedInMember)
			
            // loggedInMember가 null일 때만 openModal 함수 실행
            if (loggedInMember === 'null') {
			    openModal(); // 로그인 모달창 띄우기
			}
              

        });
        
        
        
        
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
        
        var map; // 맵 객체의 전역 변수 선언
        
     	// 맵 및 초기 레이어를 초기화합니다.
        var yonginCoords = ol.proj.fromLonLat([127.1775, 37.2410]);
        
        //-----------------기본 레이어 설정------------------------
        //기본 레이어
        var base = new ol.layer.Tile({
            source: new ol.source.XYZ({
                url: 'http://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Base/{z}/{y}/{x}.png'
            })
        });
        
        //하이브리드 레이어
        var hybrid = new ol.layer.Tile({
            source: new ol.source.XYZ({
                url: 'http://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Hybrid/{z}/{y}/{x}.png'
            })
        });
        
        //경계면 레이어
        var emd = new ol.layer.Tile({
            source: new ol.source.TileWMS({
                url: 'http://localhost:8000/geoserver/test/wms',
                params: {
                    'LAYERS': 'opengis:emd',
                    'TILED': true,
                },
                serverType: 'geoserver',
            }),
        });
        
        //링크 레이어
        var link = new ol.layer.Tile({
            source: new ol.source.TileWMS({
                url: 'http://localhost:8000/geoserver/test/wms',
                params: {
                    'LAYERS': 'opengis:LINK',
                    'TILED': true,
                },
                serverType: 'geoserver',
            }),
        });
        
        //노드 레이어
        var node = new ol.layer.Tile({
            source: new ol.source.TileWMS({
                url: 'http://localhost:8000/geoserver/test/wms',
                params: {
                    'LAYERS': 'opengis:NODE',
                    'TILED': true,
                },
                serverType: 'geoserver',
            }),
        });
        
        //맵 초기화 함수
        function initMap() {
        	
        	map = new ol.Map({
                layers: [
                    base, // 기본 레이어 추가
                    emd,
                    link,
                    node
                ],
                target: 'map', // div id map을 선택함
                view: new ol.View({
                    center: yonginCoords,
                    zoom: 11,
                }),
            });
            
        }
        
        //------------레이어 업데이트 함수들---------------
		//배경지도 업데이트 함수
        function updateMapLayer(layerSource) {
            base.setSource(layerSource);
        }
        
      	//기본 지도 
        function switchToBasic() {
            updateMapLayer(new ol.source.XYZ({
                url: 'http://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Base/{z}/{y}/{x}.png'
            }));  
        }
        
      	//위성 지도
        function switchToSatellite() {
            updateMapLayer(new ol.source.XYZ({
                url: 'http://api.vworld.kr/req/wmts/1.0.0/1BED7823-51FA-30E5-8664-4B59FDCC983E/Satellite/{z}/{y}/{x}.jpeg'
            }));
        }
        
      	//하이브리드 지도
        function switchToHybrid() {
            var hybridCheckbox = document.getElementById("btncheck3");

            if (hybridCheckbox.checked) {
                // 체크박스가 체크되었을 때만 하이브리드 레이어 추가
                if (!map.getLayers().getArray().includes(hybrid)) {
                    map.addLayer(hybrid);
                }
            } else {
                // 체크박스가 체크 해제되었을 때 하이브리드 레이어 제거
                map.removeLayer(hybrid);
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

        
        //청소비율,운행시간 조회
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
        
        //청소 레이어들 뿌려주는 콜백함수
        function drawRatio(fetchmap){
        	//운행시간 청소비율 표시할곳
        	let result = document.querySelector("#resbox"); 
        	
        	// hybrid 체크여부 값 가져오기
            let hybridCheckbox = document.getElementById("btncheck3");
        	
        	
			//car_num과 date를 선택 -> DB에 조회결과 없을때
			if(fetchmap.ratio === null){
				
				//map요소에 레이어들 초기화
				map.getLayers().clear();
				
				// 기본 레이어 다시 추가
		        map.addLayer(base); //배경지도 레이어
		        map.addLayer(emd);	//용인시 경계면 레이어
		        map.addLayer(link);	//용인시 링크
		        map.addLayer(node);	//용인시 노드
		        
		     	// hybrid 체크박스가 체크되었을 때만 hybrid 레이어 추가
		        if (hybridCheckbox.checked) {
		            map.addLayer(hybrid);
		        }
		        
		        result.innerHTML = '<p><b>데이터가 없습니다.</b></p>'
		      
		        //용인시 위도 경도
		        var newlon = 127.1775;
		        var newlat = 37.2410;
		        
		        zoomToPosition(newlon, newlat, 11); // 줌값 조절하는곳
				
			}else{
				//청소비율
	        	let ratio = fetchmap.ratio.ratio;
				//청소시간
	        	let time = fetchmap.ratio.time;
	        	
				console.log(ratio) //변수 잘 들어오는지 체크
				console.log(time)  //변수 잘 들어오는지 체크
				
				result.innerHTML = '';//HTML작성하기전에 한번 초기화해서 백지 만들어주기
				
				result.innerHTML += ''
								  +	'<p>운행 시간 : <b>'+time+'</b></p>'
			        			  +	'<p>청소 비율 : <b>'+ratio+'%</b></p>';
				
				
				//차량 번호 값 가져오기
				var carNum = document.querySelector('#selectedCarNumber').textContent;
				
				//날짜 값 가져오기
		        var date = document.querySelector('#selectDate').value; 
		        
		        console.log("패치 변수",carNum) //변수 잘 들어오는지 체크
		        console.log("패치 변수",date)   //변수 잘 들어오는지 체크
		        
		        
		        /* ----------SQL뷰 파라미터 레이어들 추가하는 곳---------- */
		        //청소O 레이어
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
		        
		        //청소X 레이어
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
		        
		        //청소 경로 레이어
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
		        
		        //청소 시작점
		        var clean_start = new ol.layer.Tile({
		            source: new ol.source.TileWMS({
		                url: 'http://localhost:8000/geoserver/test/wms',
		                params: {
		                    'LAYERS': 'opengis:Clean_start',
		                    'TILED': true,
		                    'VIEWPARAMS': "date:" + date 
		                },
		                serverType: 'geoserver',
		            }),
		        });
		        
		        //청소 끝점
		        var clean_end = new ol.layer.Tile({
		            source: new ol.source.TileWMS({
		                url: 'http://localhost:8000/geoserver/test/wms',
		                params: {
		                    'LAYERS': 'opengis:Clean_end',
		                    'TILED': true,
		                    'VIEWPARAMS': "date:" + date 
		                },
		                serverType: 'geoserver',
		            }),
		        });
		        
		        //청소 순서
		        var clean_num = new ol.layer.Tile({
		            source: new ol.source.TileWMS({
		                url: 'http://localhost:8000/geoserver/test/wms',
		                params: {
		                    'LAYERS': 'opengis:Clean_num',
		                    'TILED': true,
		                    'VIEWPARAMS': "date:" + date + ";car_num:" + carNum
		                },
		                serverType: 'geoserver',
		            }),
		        });
	        
		        
		        
		        //---------------지도 그리는 부분 -------------
		        
		      	//map 요소에 레이어들 초기화
		        map.getLayers().clear();
					
		        // 기본 레이어 다시 추가------------------------
		        map.addLayer(base); //배경지도 레이어
		        map.addLayer(emd);	//용인시 경계면 레이어
		        map.addLayer(link);	//용인시 링크
		        map.addLayer(node);	//용인시 노드
		        
		     	// hybrid 체크박스가 체크되었을 때만 hybrid 레이어 추가
		        if (hybridCheckbox.checked) {
		            map.addLayer(hybrid);
		        }

		        // 지오서버에서 SQL뷰 파라미터 레이어들 맵에 추가---------
		        map.addLayer(clean_path);	//청소 경로 레이어
		        map.addLayer(clean_O);		//청소O 레이어
		        map.addLayer(clean_X);		//청소X 레이어
		        map.addLayer(clean_num);
		        map.addLayer(clean_start);	//청소 시작점 레이어
		        map.addLayer(clean_end);	//청소 끝점 레이어

		        //새로받은 위도 경도값의 위치로 부드럽게 줌인하기
		        var newlon = fetchmap.ratio.start_lon;
		        var newlat = fetchmap.ratio.start_lat;
		        
		        console.log(newlon);
		        console.log(newlat);
		        
		        zoomToPosition(newlon, newlat, 15); // 줌값 조절하는곳
		     
		        
			}
		
			
        }
        
        //줌 애니메이션 메소드
        function zoomToPosition(lon, lat, zoomLevel) {
            var view = map.getView();
            var currentCenter = view.getCenter();
            var currentZoom = view.getZoom();

            var duration = 500; // 애니메이션 지속 시간. 값이 작을수록 줌이 빠름

            map.getView().animate({
                center: ol.proj.fromLonLat([lon, lat]),
                zoom: zoomLevel,
                duration: duration,
            });
        }
        
        
        const uploadbox = document.querySelector('.uploadbox'); // 업로드 박스 엘리먼트 선택

	     // 드래그 앤 드롭 이벤트 처리
	     uploadbox.addEventListener('dragover', (e) => {
	       e.preventDefault();
	       uploadbox.classList.add('dragover'); // 드래그 중일 때 스타일 변경
	     });
	
	     uploadbox.addEventListener('dragleave', () => {
	       uploadbox.classList.remove('dragover'); // 드래그 떠났을 때 스타일 복원
	     });
	
	     uploadbox.addEventListener('drop', (e) => {
	       e.preventDefault();
	       uploadbox.classList.remove('dragover'); // 드롭 시 스타일 복원
	
	       const files = e.dataTransfer.files; // 드래그한 파일 가져오기
	       if (files.length > 0) {
	         handleFileUpload(files); // 파일 업로드 처리 함수 호출
	       }
	     });
	
	     // 파일 업로드 처리 함수 (이전 예제와 동일)
	     function handleFileUpload(files) {
	       const formData = new FormData();
	
	       for (let i = 0; i < files.length; i++) {
	         formData.append('files', files[i]);
	       }
	
	       fetch('/test/insertMultipleCSV', {
	         method: 'POST',
	         body: formData,
	       })
	         .then((response) => response.text())
	         .then((result) => {
	           console.log(result); // 서버에서의 응답 (성공 또는 실패)
	         })
	         .catch((error) => {
	           console.error('에러:', error);
	         });
	     }



	  // 모달 열기
	     function openModal() {
	       let backdrop = document.getElementById('backdrop');
	       let modal = document.getElementById("myModal");
	       
	       modal.style.display = "block";
	       backdrop.style.display = 'block';
	     }

	     // 모달 닫기
	     function closeModal() {
	       let backdrop = document.getElementById('backdrop');
	       let modal = document.getElementById("myModal");
	       
	       modal.style.display = "none";
	       backdrop.style.display = 'none';
	     }

	     // 모달 닫기 버튼 클릭 시 닫기
	     /* var closeBtn = document.getElementsByClassName("close")[0];
	     closeBtn.addEventListener("click", closeModal); */


	     // 로그인 폼 제출 시 동작
	     var loginForm = document.getElementById("loginForm");
	     loginForm.addEventListener("submit", function(event) {
	       event.preventDefault(); // 폼 제출 기본 동작 막기
	       var id = document.getElementById("username").value;
	       var pw = document.getElementById("password").value;

		     //전달할 객체로 생성
	       let obj = {'id' : id
	       			,  'pw' : pw
	       			}
	       	
	       fetchPost('/test/loginAction/',obj,loginAction)
	       
	     });

	     function loginAction(map){
	   	    const msgBox = document.querySelector("#msgbox");
	   	    
	   	    console.log(map.msg);
	   	    
	    	 	//로그인성공
	   	 	if (map.msg === "fail") {
	   	 		//메세지처리
	   	        msgBox.innerHTML = "아이디와 비밀번호를 확인해주세요";
	   	 		
	   	 		//로그인실패
	   	    } else if (map.msg === "ok") {
	   	      	//모달 닫기
	   	        closeModal();
	   	    }
	    	 
	    	 
	     }
	

    </script>    
</body>
</html>
