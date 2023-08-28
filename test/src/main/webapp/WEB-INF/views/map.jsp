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
    
    <style>
        * {
            border: 0;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
    
        .container {
            display: flex;
        }
    
        .map-container {
            flex: 1;
            float: right;
            margin: 0;
            height: 700px;
        }
    
        .button-container {
            display: flex;
            flex-direction: column;
            justify-content: start;
            align-items: center;
            width: 20%;
            height: 700px;
            background-color: #f0f0f0;
            padding: 0;
        }
    
        .button-container h4 {
            margin-top: 20px;
            margin-bottom: 30px;
        }
    
        .button {
            display: block;
            margin-bottom: 10px;
            background-color: #007bff;
            color: #fff;
            text-align: center;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }
        
        .button-box {
            width: 95%;
            border-radius: 30px;
            background-color: white;
            margin-bottom: 20px;
        }
        
        .button-box.visionSelect {
            display: flex;
            justify-content: space-around;
            align-items: center;
        }
        
        .button-box.visionSelect input[type="radio"] {
            display: none;
        }
        
        
        .button-box.visionSelect input[type="radio"]:checked + label {
            background-color: blue;
            color: white;
        }
        
        .visionSelect {
            height: 80px;
        }
        
        .carSelect {
            height: 150px;
        }
        
        .dateSelect {
            height: 250px;
        }
    </style>
    
    <script>
        var map; // 맵 객체의 전역 변수 선언
        var baseLayer; // 기본 레이어 저장 변수
        var additionalLayers = []; // 추가 레이어 배열
        
        $(document).ready(function() {
            initMap(); // 문서가 준비되면 맵을 초기화합니다.
        });
        
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
                target: 'map',
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
    </script>
</head>
<body>
    <div class="container">
        <div class="button-container">
            <h4>용인시 청소차 관제 시스템</h4>
            
            <div class="button-box visionSelect">
                <div class="btn-group " role="group" aria-label="Basic radio toggle button group" >
	                <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked onclick="switchToBasic()">
	                <label class="btn btn-outline-primary" for="btnradio1">기본</label>
	              
	                <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off" onclick="switchToSatellite()">
	                <label class="btn btn-outline-primary" for="btnradio2">위성</label>
	              
	                <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off" onclick="switchToHybrid()">
	                <label class="btn btn-outline-primary" for="btncheck3">하이브리드</label>
            	</div>
            </div>
            
            
            
            <div class="button-box carSelect">
            </div>
            
            <div class="button-box dateSelect">
            </div>
        </div>
        <div class="map-container" id="map"></div>
    </div>
    
    
    
    
    
</body>
</html>
