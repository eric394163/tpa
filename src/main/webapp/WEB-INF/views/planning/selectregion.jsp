<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <head>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
            <style>
                .container {
                    padding: 2px 16px;
                }

                .search-box {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }

                .swiper {
                    width: 100%;
                    height: 100%;
                }

                .swiper-slide {
                    text-align: center;
                    font-size: 18px;
                    background: #fff;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }

                .swiper-slide img {
                    display: block;
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .swiper-slide p {
                    text-align: left;

                    color: #333;

                    font-size: 16px;

                    margin-top: 10px;

                }
            </style>

        </head>


        <body>
            <div class="container mt-4">
                <h2 style="text-align: center;"><span
                        style="border: #333 solid 1px; border-radius: 10px; padding: 5px">지역
                        선택</span></h2>
            </div>


            <div class="row">
                <div class="col-2"></div>
                <div class="col-8">
                    <hr>
                    <div class="search-box mb-3">
                        <div>
                            <input type="text" class="search-txt" placeholder="지역을 검색하세요">
                            <button class="search-btn">검색</button>
                        </div>
                    </div>
                    <c:forEach var="division" items="${divisionList}">
                        <h3 style="margin-bottom: 13px;">${division.division_name}</h3>
                        <hr>
                        <div style="display: flex; justify-content: center;">
                            <div class="swiper-container" style="width: 100%; height: 200px; display: flex;">
                                <c:forEach var="region" items="${division.regionList}">
                                    <div class="swiper-wrapper"
                                        style="display: flex; width: 200px; height: 200px; margin-right: 35px;">
                                        <div class="swiper-slide">
                                            <a href="<c:url value='/planning/selectstart'/>"><img
                                                    src="<c:url value='${region.region_imgUrl}'/>" alt="서울">
                                                <p>${region.region_name}</p>
                                            </a>
                                        </div>
                                    </div>
                                </c:forEach>
                                <div class="swiper-pagination"></div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
                <div class="col-2"></div>
            </div>


            <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

            <script>
                function filterRegions() {
                    var input = document.querySelector('.search-txt').value.toLowerCase();
                    var regions = document.querySelectorAll('.swiper-slide');

                    regions.forEach(function (region) {
                        var regionName = region.querySelector('p').textContent.toLowerCase();
                        if (regionName.includes(input)) {
                            region.style.display = '';
                        } else {
                            region.style.display = 'none';
                        }
                    });
                }

                document.querySelector('.search-txt').addEventListener('input', filterRegions);

                var swiper = new Swiper(".swiper-container", {
                    slidesPerView: 5,
                    spaceBetween: 30,
                    pagination: {
                        el: ".swiper-pagination",
                        clickable: true,
                    },
                });
            </script>

        </body>