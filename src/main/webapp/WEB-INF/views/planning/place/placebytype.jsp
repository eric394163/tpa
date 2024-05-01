<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <head>
            <style>

            </style>

        </head>

        <body>
            <div>
                <c:forEach items="${placeList}" var="place">
                    <div style="border: solid 1px; border-radius: 10px;">
                        <h2>${place.place_name}</h2>
                    </div>
                </c:forEach>
            </div>

        </body>