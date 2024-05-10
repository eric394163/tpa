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


                .place-content-container {
                    height: 100%;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid mt-4">
                <h2 style="text-align: center;"><span
                        style="border: #333 solid 1px; border-radius: 10px; padding: 5px">일정 생성</span></h2>
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
                                <input id="place-search" type="text" placeholder="검색">
                                <button id="submit-search">Search</button>
                            </div>
                            <hr>
                            <div class="place-content-container">
                                <div id="place-content">


                                </div>
                            </div>
                        </div>
                        <div class="add-place-area" style="display: none;">
                            <div class=" search-box mb-3 ">
                                <input id="place-add-search" type="text" placeholder="검색">
                                <button id="submit-place-add-search">Search</button>
                            </div>
                            <div class="search-place-content-container">
                                <div id="search-place-content"></div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="map box" style="height: 100%; position: relative; width: 75%; float: left;">
                    <div class="place-holder">
                        <button aria-expanded="true" class="place-holder-btn"><span class="blind">패널 접기</span></button>
                        <div class="place-holder-content" style="overflow-y: auto; ">
                        </div>

                    </div>
                    <div id="map" style="height: 100%;">
                    </div>
                </div>
            </div>
            </div>
            </div>

            <!--장소 검색 스크립트-->
            <script>
                $(document).ready(function () {
                    let currentPage = "${pm.cri.page}";  // 현재 페이지 번호를 추적
                    let currentType = "";  // 현재 선택된 타입
                    let count = "${pm.totalCount}";  // 전체 데이터 수
                    let isSearch = false;  // 검색 여부 플래그
                    let search = "";  // 검색어

                    // 장소 유형 버튼 클릭 이벤트
                    $("#recommend-btn, #restaurant-btn, #room-btn, #spot-btn, #cafe-btn").click(function () {
                        isSearch = false;
                        search = "";
                        currentType = $(this).text();  // 클릭한 버튼의 텍스트(장소 유형) 저장
                        currentPage = 1;  // 새 유형을 선택하면 페이지 번호 초기화
                        fetchPlaces(currentType, currentPage, isSearch, search);  // 데이터 가져오기
                    });

                    // 검색 버튼 클릭 이벤트
                    $("#submit-search").click(function (e) {
                        e.preventDefault();

                        search = $("#place-search").val();
                        if (!search) {
                            alert("검색어를 입력하세요.");
                            return;
                        }

                        isSearch = true;
                        currentPage = 1;
                        fetchPlaces(currentType, currentPage, isSearch, search);
                    });

                    // 더보기 버튼 클릭 이벤트
                    $(document).on('click', '#load-more', function () {
                        currentPage++;  // 클릭할 때마다 페이지 번호 증가
                        fetchPlaces(currentType, currentPage, isSearch, search);  // 새 페이지 번호로 데이터 요청
                    });

                    // 장소 데이터 가져오기 함수
                    function fetchPlaces(type, pageNumber, isSearch, search) {
                        $.ajax({
                            url: isSearch ? "<c:url value='/planning/searchplace'/>" : "<c:url value='/planning/placebytype'/>",
                            type: "GET",
                            data: {
                                currentPage: pageNumber,
                                type: type,
                                search: search,
                                themeNum: "${themeNum}",
                                regionNum: "${regionNum}",
                            },
                            dataType: "html",
                            success: function (data) {
                                $('#load-more').remove();
                                if (data.trim().length) {
                                    if (pageNumber === 1) {
                                        $("#place-content").html(data);  // 첫 페이지이면 대체
                                    } else {
                                        $("#place-content").append(data);  // 추가 페이지일 경우 추가
                                    }
                                }


                            },
                            error: function (xhr, status, error) {
                                console.error(xhr);
                            }
                        });
                    }
                });

            </script>





            <!--장소 보관함 스크립트-->
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const button = document.querySelector('.place-holder-btn');
                    const placeHolder = document.querySelector('.place-holder');

                    button.addEventListener('click', function () {
                        if (placeHolder.style.transform === 'translateX(-100%)') {
                            // 플레이스 홀더 보이기
                            placeHolder.style.transform = 'translateX(0)';
                        } else {
                            // 플레이스 홀더 숨김
                            placeHolder.style.transform = 'translateX(-100%)';
                        }
                    });
                });
            </script>

           

           


            <script
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_dbDJ50HoF3zG_26w0y5gnCUDoL7RskA&callback=initMap&libraries=places&v=weekly"
                defer></script>


        </body>