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
                            // 플레이스 홀더 보이기
                            placeHolder.style.transform = 'translateX(0)';
                        } else {
                            // 플레이스 홀더 숨김
                            placeHolder.style.transform = 'translateX(-100%)';
                        }
                    });
                });
            </script>

            <!-- 장소 보관함에 장소 추가 스크립트 -->
            <script>
                let map;
                let markers = [];
                let regionLat = "${regionLat}";
                let regionLng = "${regionLng}";

                function initMap() {
                    const firstLocation = new google.maps.LatLng(regionLat, regionLng);
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
                            const placeId = e.target.dataset.placeId;
                            const latitude = parseFloat(e.target.dataset.lat);
                            const longitude = parseFloat(e.target.dataset.lng);
                            addToPlaceHolder(placeName, placeId, latitude, longitude);
                        } else if (e.target.classList.contains('remove-place')) {
                            const placeId = e.target.dataset.placeId;
                            removePlaceAndMarker(placeId);
                        }
                    });

                    function addToPlaceHolder(placeName, placeId, lat, lng) {
                        const placeHolder = document.querySelector('.place-holder');
                        if (!placeHolder) {
                            console.error('Place holder element not found.');
                            return;
                        }

                        if (isPlaceAdded(placeId)) {
                            alert("이미 추가한 장소입니다.");
                            return;
                        }

                        const newPlace = document.createElement('div');
                        newPlace.innerHTML = `<strong>(ID: \${placeId}) \${placeName}</strong>
                                              <span class="remove-place" data-place-id="\${placeId}" style="cursor:pointer;color:red;margin-left:10px;">x</span>`;
                        newPlace.setAttribute('data-place-id', placeId);
                        newPlace.style.padding = '10px';
                        newPlace.style.borderBottom = '1px solid #ccc';
                        placeHolder.appendChild(newPlace);

                        createMarker({ lat: lat, lng: lng, placeName: placeName, placeId: placeId });
                    }

                    function createMarker(place) {
                        const position = new google.maps.LatLng(place.lat, place.lng);
                        const marker = new google.maps.Marker({
                            map: map,
                            position: position,
                            title: place.placeName
                        });
                        marker.placeId = place.placeId;
                        markers.push(marker);
                        map.setCenter(position);
                    }

                    function removePlaceAndMarker(placeId) {

                        const place = document.querySelector(`div[data-place-id="\${placeId}"]`);
                        if (place) {
                            place.parentNode.removeChild(place);
                        }


                        const marker = markers.find(m => m.placeId === placeId);
                        if (marker) {
                            marker.setMap(null);
                            markers = markers.filter(m => m !== marker);
                        }
                    }

                    function isPlaceAdded(placeId) {
                        const existingPlaces = document.querySelectorAll('.place-holder div[data-place-id]');
                        return Array.from(existingPlaces).some(place => place.getAttribute('data-place-id') === placeId);
                    }
                });
            </script>

            <!-- 장소 추가 검색 스크립트 -->
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    let searchInput = document.getElementById('place-add-search');
                    let searchBtn = document.getElementById('submit-place-add-search');
                    let searchResultsContainer = document.getElementById('search-place-content');

                    let autocomplete;
                    let placesService;
                    let regionNum = "${regionNum}";
                    console.log(regionNum);



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
                        console.log(regionLat, regionLng);
                        placesService.textSearch({
                            query: query,
                            language: 'ko',
                            // location: new google.maps.LatLng(regionLat, regionLng),
                            // radius: 20000,  // 20km
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
                            div.style.border = 'solid 1px';
                            div.style.borderRadius = '10px';
                            div.style.display = 'flex';

                            let h2 = document.createElement('h2');
                            h2.textContent = place.name;
                            div.appendChild(h2);

                            let button = document.createElement('button');
                            button.id = 'user-add-place-to-place-holder';
                            button.dataset.placeName = place.name;
                            button.dataset.placeId = place.place_id;
                            button.dataset.lat = place.geometry.location.lat();
                            button.dataset.lng = place.geometry.location.lng();
                            button.dataset.address = place.formatted_address;
                            button.dataset.regionNum = regionNum;
                            button.dataset.placeRating = place.rating;
                            button.textContent = '+';
                            div.appendChild(button);

                            searchResultsContainer.appendChild(div);


                            button.addEventListener('click', function () {
                                event.stopPropagation(); // 이벤트 전파 중지
                                addToPlaceHolderUser(regionNum, place.rating, place.name, place.place_id, place.formatted_address, place.geometry.location.lat(), place.geometry.location.lng());
                            });
                        });
                    }

                    function addToPlaceHolderUser(regionNum, placeRating, placeName, placeId, placeAddress, lat, lng) {

                        $.ajax({
                            url: "<c:url value='/planning/useraddplace'/>",
                            type: 'POST',
                            data: {
                                regionNum: regionNum,
                                placeRating: placeRating,
                                placeId: placeId,
                                placeName: placeName,
                                lat: lat,
                                lng: lng,
                                placeAddress: placeAddress

                            },
                            success: function (response) {
                                if (response.status === 'exists') {
                                    alert('이미 저장된 장소입니다.');
                                } else if (response.status === 'added') {
                                    const placeHolder = document.querySelector('.place-holder');
                                    const newPlace = document.createElement('div');
                                    newPlace.innerHTML = `<strong>(ID: \${placeId}) \${placeName}</strong>
                                          <span class="remove-place" data-place-id="\${placeId}" style="cursor:pointer;color:red;margin-left:10px;">x</span>`;
                                    newPlace.setAttribute('data-place-id', placeId);
                                    newPlace.style.padding = '10px';
                                    newPlace.style.borderBottom = '1px solid #ccc';
                                    placeHolder.appendChild(newPlace);
                                    // createMarker({ lat: lat, lng: lng, placeName: placeName, placeId: placeId });
                                }
                            },
                            error: function (xhr, status, error) {
                                console.error(xhr);
                            }
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