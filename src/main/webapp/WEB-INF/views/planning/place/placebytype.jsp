<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <head>
            <style>

            </style>

        </head>

        <body>
            <div>
                <c:forEach items="${placeList}" var="place">
                    <div style="border: solid 1px; border-radius: 10px; display: flex;">
                        <h2>${place.place_name}</h2>
                        <button id="add-to-place-holder" data-place-name="${place.place_name}" data-place-id="${place.place_id}"
                            data-lat="${place.place_lat}" data-lng="${place.place_lng}" data-place-num="${place.place_NUM}">+</button>
                    </div>
                </c:forEach>


            </div>
            <c:if test="${pm.totalCount > pm.cri.page*pm.cri.perPageNum}">
                <!-- pm.totalCount : 전체 게시물 수, pm.cri.page*pm.cri.perPageNum : 현재 페이지에 보여줄 게시물 수 페이지 초과되면 숨기기 -->
                <button id="load-more" style="display: block; margin: 20px auto;">Load More</button>
            </c:if>







        </body>