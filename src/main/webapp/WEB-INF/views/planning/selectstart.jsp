<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
        <style>
            /* 여기에 CSS 코드 추가 */
            #map {
                height: 100%;
            }

            .search-box {
                display: flex;
                justify-content: center;
                align-items: center;
            }
        </style>

        <body>

            <div class="container-fluid mt-4">
                <h2 style="text-align: center;"><span
                        style="border: #333 solid 1px; border-radius: 10px; padding: 5px">출발지
                        선택</span></h2>
            </div>
            <div class="row">
                <div class="col-2"></div>
                <div class="col-8">
                    <hr>
                    <div class="search-box mb-3 ">
                        <input id="place-search" type="text" placeholder="검색">
                        <button id="submit-search">Search</button>
                    </div>
                    <form id="selectStart" action="<c:url value='/planning/selectplace'/>" method="post">
                        <input type="hidden" name="startDate" value="${startDate}">
                        <input type="hidden" name="endDate" value="${endDate}">
                        <input type="hidden" name="regionNum" value="${regionNum}">
                        <input type="hidden" name="themeNum" value="${themeNum}">
                        <input type="hidden" id="startPlaceId" name="startPlaceId" value="">
                        <input type="hidden" id="startPlaceLat" name="startPlaceLat" value="">
                        <input type="hidden" id="startPlaceLng" name="startPlaceLng" value="">
                        <button type="submit" id="submitStart">출발지 선택</button>
                    </form>
                </div>
                <div class="col-2">

                </div>
            </div>
            <div class="map box" style="height: 600px;">
                <div id="map"></div>

            </div>

    




            <script type="module">

                let map;
                let service;
                let infowindow;
                let markers = []; // 마커를 저장할 배열

                // ======== 지도 초기화 및 생성 ========
                function initMap() {
                    const firstLocation = new google.maps.LatLng(31.495484, 127.033357);

                    map = new google.maps.Map(document.getElementById("map"), { // 지도 생성
                        center: firstLocation,  // 중심 좌표
                        zoom: 15, // 확대 수준
                    });
                    infowindow = new google.maps.InfoWindow();

                    const locationButton = document.createElement("button");

                    locationButton.textContent = "현재위치";
                    locationButton.classList.add("custom-map-control-button");
                    map.controls[google.maps.ControlPosition.TOP_CENTER].push(locationButton);
                    locationButton.addEventListener("click", () => {
                        // Try HTML5 geolocation.
                        if (navigator.geolocation) {
                            navigator.geolocation.getCurrentPosition(
                                (position) => {
                                    const pos = {
                                        lat: position.coords.latitude,
                                        lng: position.coords.longitude,
                                    };
                                    // console.log(pos);
                                    // infowindow.setPosition(pos);
                                    // infowindow.setContent("Location found.");
                                    infowindow.open(map);
                                    map.setCenter(pos);
                                    createMarker({ geometry: { location: pos } });



                                },
                                () => {
                                    handleLocationError(true, infoWindow, map.getCenter());
                                }
                            );
                        } else {
                            // Browser doesn't support Geolocation
                            handleLocationError(false, infoWindow, map.getCenter());
                        }
                    });
                }




                //====== 검색 버튼 클릭 시 실행 ======
                document.getElementById('submit-search').addEventListener('click', function () {
                    const query = document.getElementById('place-search').value; // 사용자 입력 값 가져오기
                    const request = {
                        query: query,
                        fields: ['name', 'place_id', 'geometry', 'formatted_address', 'rating', 'opening_hours'],
                    };
                    service = new google.maps.places.PlacesService(map);
                    service.findPlaceFromQuery(request, (results, status) => {
                        if (status === google.maps.places.PlacesServiceStatus.OK && results) {
                            // for (let i = 0; i < results.length; i++) {
                            //     createMarker(results[i]);
                            // }
                            // map.setCenter(results[0].geometry.location);
                            // displayPlaceDetails(results[0]);
                            map.setCenter(results[0].geometry.location);
                            createMarker(results[0]); // 마커 생성 함수 호출
                            // displayPlaceDetails(results[0]); // 상세 정보 표시
                        }
                    });
                });


                // ======== 마커 관련 함수  ========

                //마커생성
                function createMarker(place) {
                    let placeId = place.place_id;
                    let lat = place.geometry.location.lat;
                    let lng = place.geometry.location.lng;
                    if (!place.geometry || !place.geometry.location) return; // geometry 또는 location이 없으면 함수 종료
                    clearMarkers();
                    const marker = new google.maps.Marker({ // 마커 생성
                        map, // 지도
                        position: place.geometry.location, // 위치
                    });

                    updateLocationInputs(lat, lng, placeId);
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

                // 위치 정보를 가져오지 못했을 때 ( 현재 위치 선택 )
                function handleLocationError(browserHasGeolocation, infoWindow, pos) {
                    infoWindow.setPosition(pos);
                    infoWindow.setContent(
                        browserHasGeolocation
                            ? "Error: The Geolocation service failed."
                            : "Error: Your browser doesn't support geolocation."
                    );
                    infoWindow.open(map);
                }

                // 위치 정보를 보내기 
                function updateLocationInputs(lat, lng, placeId) {
                    if (placeId !== undefined) {
                        document.getElementById("startPlaceId").value = placeId;
                        console.log(placeId);

                    } else {
                        document.getElementById("startPlaceLat").value = lat;
                        document.getElementById("startPlaceLng").value = lng;
                    }
                }

            </script>
            <script
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_dbDJ50HoF3zG_26w0y5gnCUDoL7RskA&callback=initMap&libraries=places&v=weekly"
                defer></script>
        </body>