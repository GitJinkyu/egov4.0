<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <title>Random Value Sender</title>
</head>
<body>
    <h1>Random Value Sender</h1>
    
    <script type="text/javascript">
    function sendRandomValues() {
        // 랜덤한 두 개의 값을 생성
        var lon = Math.floor(Math.random() * 100);
        var lat = Math.floor(Math.random() * 100);
        var noise = Math.floor(Math.random() * (121 - 60) + 60); // 60 이상 120 이하의 랜덤 정수
        var rpm = Math.floor(Math.random() * (1701 - 1300) + 1300); // 1300 이상 1700 이하의 랜덤 정수

        

        // 요청 데이터 생성
        var data = {
            lon: lon,
            lat: lat,
            car_num: '101가1234',
            noise: noise,
            rpm: rpm,
            
        };

        // fetch를 사용하여 POST 요청 보내기
        fetch("/GPS/insert", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            body: JSON.stringify(data)
	        })
	        .then(function(response) {
	            if (!response.ok) {
	                throw new Error("HTTP error, status = " + response.status);
	            }
	            return response.json(); // JSON 형식으로 응답 데이터를 파싱
	        })
	        .then(function(res) {
	            // 서버 응답을 처리하는 코드를 여기에 작성합니다.
	            console.log("서버 응답:", res);
	        })
	        .catch(function(error) {
	            // 에러 처리 코드를 여기에 작성합니다.
	            console.error("에러:", error);
	        });
	    }

        // 페이지가 로드되면 10초마다 sendRandomValues 함수를 호출
        window.onload = function() {
            setInterval(sendRandomValues, 5000);
        };
    </script>
    
    ㅎㅇㅎㅇ
</body>
</html>
