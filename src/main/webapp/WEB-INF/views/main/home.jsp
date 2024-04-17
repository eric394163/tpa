<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
		<!doctype html>
		<html>

		<head>
			<title>Home</title>

		</head>

		<body>
			<div class="main-content row">
				<jsp:include page="/WEB-INF/views/main/main.jsp" />
				<div class="col-2">

				</div>
				<div class="col-8">
					<jsp:include page="/WEB-INF/views/main/mostfollow.jsp" />
					<jsp:include page="/WEB-INF/views/main/mostview.jsp" />
				</div>
				<div class="col-2">

				</div>

			</div>

		</body>

		</html>