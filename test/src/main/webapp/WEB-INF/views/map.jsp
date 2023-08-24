<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
gㅎㅇㅎㅇㅎㅇ

<c:forEach items="${list}" var="l">
	<div>${l.id }</div>
	<div>${l.text }</div>
	<div>${l.name }</div>
</c:forEach>

</body>
</html>