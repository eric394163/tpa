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

                    </div>
                    <div id="map" style="height: 100%;">
                    </div>
                </div>
            </div>
            </div>
            </div>

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


            <!--장소 선택/추가 버튼 스트=크립트-->
            <script type="text/javascript">
                $(document).ready(function () {
                    //탭바처리 제이쿼리
                    $('.add-place-area').hide();
                    $(".btn-area a").click(function () { //버튼 클릭
                        //버튼 CSS활성
                        $(".btn-area a").removeClass('active'); // 모든 버튼에 active클래스 제거
                        $(this).addClass('active'); // 클릭한 버튼에만 active클래스 추가

                        //컨텐츠 보이게 처리
                        let index = $(this).parent().index();
                        $(".contents-wrap > div").fadeOut(0); //모든 컨텐츠 숨김
                        $(".contents-wrap > div").eq(index).fadeIn(0); // 클릭한 버튼에 해당하는 컨텐츠만 보이게
                    });
                    $('.btn-area a:first').trigger('click'); //   첫번째 버튼 클릭
                    $('#recommend-btn').trigger('click');


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

            <!-- 장소 보관함에 장소 추가 스크립트 -->
            <script>
                let map;
                let markers = [];

                function initMap() {
                    const firstLocation = new google.maps.LatLng(37.495484, 127.033357);
                    map = new google.maps.Map(document.getElementById("map"), {
                        center: firstLocation,
                        zoom: 15
                    });
                }

                window.initMap = initMap;

                document.addEventListener('DOMContentLoaded', function () {
                    document.body.addEventListener('click', function (e) {
                        if (e.target.dataset.placeName) {
                            const placeName = e.target.dataset.placeName;
                            const placeNum = e.target.dataset.placeNum;
                            const latitude = parseFloat(e.target.dataset.lat);
                            const longitude = parseFloat(e.target.dataset.lng);
                            addToPlaceHolder(placeName, placeNum, latitude, longitude);
                        } else if (e.target.classList.contains('remove-place')) {
                            const placeNum = e.target.dataset.placeNum;
                            removePlaceAndMarker(placeNum);
                        }
                    });

                    function addToPlaceHolder(placeName, placeNum, lat, lng) {
                        const placeHolder = document.querySelector('.place-holder');
                        if (!placeHolder) {
                            console.error('Place holder element not found.');
                            return;
                        }

                        if (isPlaceAdded(placeNum)) {
                            alert("This place is already added.");
                            return;
                        }

                        const newPlace = document.createElement('div');
                        newPlace.innerHTML = `<strong>(ID: \${placeNum}) \${placeName}</strong>
                                              <span class="remove-place" data-place-num="\${placeNum}" style="cursor:pointer;color:red;margin-left:10px;">x</span>`;
                        newPlace.setAttribute('data-place-num', placeNum);
                        newPlace.style.padding = '10px';
                        newPlace.style.borderBottom = '1px solid #ccc';
                        placeHolder.appendChild(newPlace);

                        createMarker({ lat: lat, lng: lng, placeName: placeName, placeNum: placeNum });
                    }

                    function createMarker(place) {
                        const position = new google.maps.LatLng(place.lat, place.lng);
                        const marker = new google.maps.Marker({
                            map: map,
                            position: position,
                            title: place.placeName
                        });
                        marker.placeNum = place.placeNum; // Associate the placeNum with the marker
                        markers.push(marker);
                        map.setCenter(position);
                    }

                    function removePlaceAndMarker(placeNum) {
                        // Remove the place div
                        const place = document.querySelector(`div[data-place-num="\${placeNum}"]`);
                        if (place) {
                            place.parentNode.removeChild(place);
                        }

                        // Find and remove the marker
                        const marker = markers.find(m => m.placeNum === placeNum);
                        if (marker) {
                            marker.setMap(null);
                            markers = markers.filter(m => m !== marker);
                        }
                    }

                    function isPlaceAdded(placeNum) {
                        const existingPlaces = document.querySelectorAll('.place-holder div[data-place-num]');
                        return Array.from(existingPlaces).some(place => place.getAttribute('data-place-num') === placeNum);
                    }
                });
            </script>

            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    let searchInput = document.getElementById('place-add-search');
                    let searchBtn = document.getElementById('submit-place-add-search');
                    let searchResultsContainer = document.getElementById('search-place-content');

                    let autocomplete;  // Google places autocomplete 객체
                    let placesService;  // Google places service 객체

                    function initGooglePlaces() {
                        let map = new google.maps.Map(document.createElement('div'));
                        autocomplete = new google.maps.places.Autocomplete(searchInput);
                        autocomplete.bindTo('bounds', map);
                        placesService = new google.maps.places.PlacesService(map);
                    }

                    function searchPlaces() {
                        let query = searchInput.value;
                        if (!query) {
                            alert('검색어를 입력해주세요.');
                            return;
                        }
                        placesService.textSearch({
                            query: query,
                            language: 'ko',
                            // location: new google.maps.LatLng(coords.lat, coords.lng),
                            // radius: 5000, // 5km 반경
                        }, function (results, status) {
                            if (status === google.maps.places.PlacesServiceStatus.OK) {
                                displayResults(results);
                            } else {
                                searchResultsContainer.innerHTML = '검색 결과가 없습니다.';
                            }
                        });
                    }

                    function displayResults(results) {
                        searchResultsContainer.innerHTML = '';
                        results.forEach(function (place) {
                            let div = document.createElement('div');
                            div.textContent = place.name;
                            searchResultsContainer.appendChild(div);
                        });
                    }

                    searchBtn.addEventListener('click', function (event) {
                        event.preventDefault();
                        searchPlaces();
                    });

                    initGooglePlaces();
                });
            </script>

            <script
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_dbDJ50HoF3zG_26w0y5gnCUDoL7RskA&callback=initMap&libraries=places&v=weekly"
                defer></script>


        </body>