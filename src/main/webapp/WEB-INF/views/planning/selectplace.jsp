<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <head>
            <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
            <style>
                .main-container {
                    height: 100vh;
                    position: relative;
                }

                .side-box {
                    height: 100%;
                    width: 25%;
                    position: relative;
                    z-index: 300;
                    background-color: #f1f1f1;
                    float: left;
                }

                .place-holder {
                    position: absolute;
                    top: 0px;
                    min-width: 30%;
                    bottom: 0px;
                    z-index: 200;
                    height: 100%;
                    background-color: #f1f1f1;
                    transform: translateX(-0%);


                }

                .place-holder-btn {
                    position: absolute;
                    top: 50%;
                    left: 100%;
                    transform: translateY(-50%);
                    z-index: 10;
                    overflow: hidden;
                    display: inline-block;
                    font-size: 1px;
                    line-height: 1px;
                    color: transparent;
                    vertical-align: top;
                    width: 22px;
                    height: 49px;
                    mask-image: none;
                }

                #map {

                    display: block;
                    position: relative;
                    height: 100%;
                }

                .search-box {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }

                .btn-area {
                    list-style: none;
                    padding: 0;
                    margin: 0;
                    margin-bottom: 20px;
                    display: flex;
                    /* margin-block-start: 1em;
            margin-block-end: 1em;
            margin-inline-start: 0px;
            margin-inline-end: 0px;
            padding-inline-start: 40px; */
                }

                .btn-area a.active {
                    border: 2px solid #000;
                    color: #000;
                }

                .btn-area a {
                    display: inline-block;
                    padding: 6px 30px;
                    border: 2px solid #999;
                    color: #999;
                    border-radius: 50px;
                    text-decoration: none;
                    font-weight: bold;
                }

                .place-content-container {
                    height: 100%;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid mt-4">
                <h2 style="text-align: center;"><span
                        style="border: #333 solid 1px; border-radius: 10px; padding: 5px">장소
                        선택</span></h2>
            </div>
            <div class="row">
                <div class="col-2"></div>
                <div class="col-8">
                    <hr>

                </div>
                <div class="col-2">

                </div>
            </div>
            <div class="main-container" style="height:100vh ;">
                <div class="side-box" style="min-width: 150px;">
                    <ul class="btn-area">
                        <li><a href="#selectplace" class="active">장소 선택</a></li>
                        <li><a href="#addplace">장소 추가</a></li>
                    </ul>
                    <div class="contents-wrap">
                        <div class="select-place-area">

                            <div style="display: flex; align-items: center; justify-content: center;">
                                <button id="recommend-btn">추천</button>
                                <button id="restaurant-btn">식당</button>
                                <button id="room-btn">숙소</button>
                                <button id="spot-btn">관광지</button>
                                <button id="cafe-btn">카페</button>
                            </div>
                            <hr>
                            <div class=" search-box mb-3 ">
                                <input id=" place-search" type="text" placeholder="검색">
                                <button id="submit-search">Search</button>
                            </div>
                            <hr>
                            <div class="place-content-container">
                                <div id="place-content">
                                    <c:forEach var="place" items="${placeList}">
                                        <div class="place">
                                            <div class="place-info">
                                                <h3>${place.place_name}</h3>
                                            </div>
                                        </div>

                                    </c:forEach>

                                </div>
                            </div>
                        </div>
                        <div class="add-place-area">
                            <div class=" search-box mb-3 ">
                                <input id=" place-add-search" type="text" placeholder="검색">
                                <button id="submit-place-add-search">Search</button>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="map box" style="height: 100%; position: relative; width: 75%; float: left;">

                    <div class="place-holder">

                        <button aria-expanded="true" class="place-holder-btn"><span class="blind">패널 접기</span></button>

                    </div>
                    <div id="map" style="height: 100%;">
                    </div>
                </div>
            </div>
            </div>
            </div>

            <!--타입 선택 스크립트-->
            <script>
                $(document).ready(function () {
                    $("#recommend-btn, #restaurant-btn, #room-btn, #spot-btn, #cafe-btn").click(function () {
                        var type = $(this).text();
                        fetchPlaces(type);
                    });

                    function fetchPlaces(type) {
                        $.ajax({
                            url: "<c:url value='/planning/placebytype'/>",
                            type: "GET",
                            data: {
                                type: type,
                                themeNum: "${themeNum}",
                                regionNum: "${regionNum}",
                            },
                            dataType: "html",
                            success: function (data) {
                                $("#place-content").html(data);
                            },
                            error: function (xhr, status, error) {
                                console.error(xhr);
                            }
                        });
                    }
                });
            </script>

            <!--장소 선택/추가 버튼 스트=크립트-->
            <script type="text/javascript">
                //탭바처리 제이쿼리
                $(".btn-area a").click(function () { //버튼 클릭
                    //버튼 CSS활성
                    $(".btn-area a").removeClass('active');
                    $(this).addClass('active');

                    //컨텐츠 보이게 처리
                    let index = $(this).parent().index();
                    $(".contents-wrap > div").fadeOut(0);
                    $(".contents-wrap > div").eq(index).fadeIn(0);
                });
            </script>

            <!-- 장소 검색 스크립트 -->
            <script>
                $(document).ready(function () {
                    // 검색 버튼 클릭 이벤트 핸들러
                    $("#submit-search").click(function (e) {
                        e.preventDefault();  // 폼 제출을 막습니다.

                        var search = $("#place-search").val(); // 입력 필드에서 검색어를 가져옵니다.
                        if (!search) {
                            alert("검색어를 입력하세요.");
                            return; // 검색어가 없으면 종료
                        }

                        $.ajax({
                            url: "/planning/searchplace", // 서버의 검색 API URL
                            type: "GET",
                            data: {
                                query: search, // 데이터로 검색어를 전달
                            },
                            dataType: "html",
                            success: function (data) {
                                $("#place-content").html(data); // 성공 시 받은 데이터로 내용 업데이트
                            },
                            error: function (xhr, status, error) {
                                console.error("검색 오류: " + error);
                            }
                        });
                    });
                });
            </script>


            <!--장소 보관함 스크립트-->
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const button = document.querySelector('.place-holder-btn');
                    const placeHolder = document.querySelector('.place-holder');

                    button.addEventListener('click', function () {
                        if (placeHolder.style.transform === 'translateX(-100%)') {
                            // 플레이스 홀더를 다시 보이게 합니다.
                            placeHolder.style.transform = 'translateX(0)';
                        } else {
                            // 플레이스 홀더를 숨깁니다.
                            placeHolder.style.transform = 'translateX(-100%)';
                        }
                    });
                });
            </script>

            <!-- 지도 스크립트-->
            <script type="module">

                let map;
                let service;
                let infowindow;
                let markers = []; // 마커를 저장할 배열

                // ======== 지도 초기화 및 생성 ========
                function initMap() {
                    const firstLocation = new google.maps.LatLng(37.495484, 127.033357);

                    map = new google.maps.Map(document.getElementById("map"), { // 지도 생성
                        center: firstLocation,  // 중심 좌표
                        zoom: 15, // 확대 수준
                    });
                    infowindow = new google.maps.InfoWindow();

                }




                // ======== 마커 관련 함수  ========

                //마커생성
                function createMarker(place) {
                    if (!place.geometry || !place.geometry.location) return; // geometry 또는 location이 없으면 함수 종료
                    clearMarkers();
                    const marker = new google.maps.Marker({ // 마커 생성
                        map, // 지도
                        position: place.geometry.location, // 위치
                    });
                    markers.push(marker);
                }

                // 기존에 표시된 모든 마커를 지도에서 제거
                function clearMarkers() {
                    for (let marker of markers) {
                        marker.setMap(null);
                    }
                    markers = []; // 배열 초기화
                }


                window.initMap = initMap;


            </script>
            <script
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_dbDJ50HoF3zG_26w0y5gnCUDoL7RskA&callback=initMap&libraries=places&v=weekly"
                defer></script>
        </body>