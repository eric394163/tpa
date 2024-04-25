<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <style>
            /* Basic styling */
            .calendar-navigation {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 100%;
            }

            .calendar-container-fluid {
                display: inline-block;
                margin: 10px;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                user-select: none;
                height: 330px;
                width: auto;

            }

            .header,
            .week-days,
            .days {
                display: flex;
            }

            .header div,
            .week-days div {
                width: 40px;
                height: 40px;
                line-height: 30px;
                text-align: center;
            }

            .week-days div {
                font-weight: bold;
                display: flex;
                justify-content: center;
                align-items: center;
                /*간격 균등하게 띄우기 */


            }

            .days div {
                cursor: pointer;
                width: 40px;
                height: 35px;
                line-height: 30px;
                text-align: center;
            }

            .days div:hover {
                background-color: #eee;
            }

            .selected {
                background-color: #add8e6;


            }

            .selected-single {
                background-color: #add8e6;
                /* 파란색 */

            }

            .range {
                background-color: #ffff99;
                /* 범위에 대한 밝은 노란색 배경 */
            }

            #prevMonth,
            #nextMonth {
                border: none;
                font-size: 24px;
                cursor: pointer;
                background-color: white;
            }

            #submitDate {
                display: block;
                margin: 20px auto;
                padding: 10px 20px;
                border: none;
                cursor: pointer;
                border: 1px solid #ccc;
                border-radius: 10px;
                background-color: white;
            }

            .month-header {
                margin-top: 10px;
                text-align: center;
                margin-bottom: 10px;
                font-size: 20px;
                font-weight: bold;
            }

            .calendar-body {

                display: flex;
                flex-direction: column;
                margin-left: 10px;
                margin-top: 10px;

            }
        </style>
        </head>

        <body>
            <div class="container-fluid mt-4">
                <h2 style="text-align: center;"><span
                        style="border: #333 solid 1px; border-radius: 10px; padding: 5px">일정 선택</span></h2>
            </div>
            <div class="row">
                <div class="col-2"></div>
                <div class="col-8">
                    <hr>


                    <div class="calendar-navigation">
                        <button id="prevMonth">&#60;</button>
                        <div id="calendar1" class="calendar-container-fluid">

                        </div>
                        <div id="calendar2" class="calendar-container-fluid">

                        </div>
                        <button id="nextMonth">&#62;</button>
                    </div>
                    <form id="dateForm" action="<c:url value='/planning/selectstart'/>" method="post">
                        <input type="hidden" id="startDate" name="startDate">
                        <input type="hidden" id="endDate" name="endDate">
                        <input type="hidden" name="region_NUM" value="${region_NUM}">
                        <input type="hidden" name="theme_NUM" value="${theme_NUM}">
                        <button type="submit" id="submitDate">일정 선택</button>
                    </form>

                </div>
                <div class="col-2"></div>
            </div>


            <script>
                let selectedDates = { start: null, end: null };

                function clearRange() {
                    document.querySelectorAll('.range').forEach(el => el.classList.remove('range'));
                    document.querySelectorAll('.selected').forEach(el => el.classList.remove('selected'));
                }

                function updateRange() {
                    if (!selectedDates.start || !selectedDates.end) return;

                    let start = new Date(selectedDates.start);
                    let end = new Date(selectedDates.end);
                    if (start > end) [start, end] = [end, start];

                    const maxEndDate = new Date(start);
                    maxEndDate.setDate(start.getDate() + 6); // 시작 날짜로부터 7일 이내
                    if (end > maxEndDate) {
                        end = maxEndDate; // 두 번째 선택 날짜가 7일 초과하는 경우, 최대 범위로 조정
                    }

                    let iterDate = new Date(start);
                    while (iterDate <= end) {
                        const dayElement = document.getElementById(`day-\${iterDate.getFullYear()}-\${iterDate.getMonth() + 1}-\${iterDate.getDate()}`);
                        if (dayElement) {
                            dayElement.classList.add('range');
                        }
                        iterDate.setDate(iterDate.getDate() + 1);
                    }
                    selectedDates.end = end; // 실제 선택된 종료 날짜 업데이트
                }

                let clickCount = 0; // 클릭 횟수 추적을 위한 변수

                function clearAll() {
                    document.querySelectorAll('.days div').forEach(el => {
                        el.classList.remove('selected');
                        el.classList.remove('range');
                    });
                    selectedDates = { start: null, end: null };
                    clickCount = 0; // 클릭 카운터 초기화
                }

                function selectDate(dateStr) {
                    clickCount++; // 클릭 수 증가
                    const date = new Date(dateStr);
                    const dayElementId = `day-\${date.getFullYear()}-\${date.getMonth() + 1}-\${date.getDate()}`;
                    const dayElement = document.getElementById(dayElementId);

                    if (clickCount === 3) {
                        clearAll();
                        return; // 세 번째 클릭시 모든 선택 초기화 
                    }

                    if (!selectedDates.start || selectedDates.end) {
                        if (selectedDates.start && (selectedDates.start.toISOString() === date.toISOString())) {

                            dayElement.classList.remove('selected');
                            selectedDates.start = null;
                            selectedDates.end = null;
                            return;
                        }
                        clearRange();
                        selectedDates.start = date;
                        selectedDates.end = null;
                        dayElement.classList.add('selected');
                    } else {
                        const maxEndDate = new Date(selectedDates.start);
                        maxEndDate.setDate(maxEndDate.getDate() + 6);
                        if (date > maxEndDate) {
                            selectedDates.end = maxEndDate;
                        } else {
                            selectedDates.end = date;
                        }
                        updateRange();
                    }
                }

                function createCalendar(containerId, year, month) {
                    const container = document.getElementById(containerId);
                    container.innerHTML = ''; // Clear previous content

                    const monthHeader = document.createElement('div');
                    monthHeader.className = 'month-header';
                    const monthNames = ["January", "February", "March", "April", "May", "June",
                        "July", "August", "September", "October", "November", "December"];
                    monthHeader.textContent = `\${monthNames[month - 1]} \${year}`;
                    container.appendChild(monthHeader);

                    // Create a new container for weekdays and week rows
                    const calendarBody = document.createElement('div');
                    calendarBody.className = 'calendar-body';

                    const today = new Date();
                    const daysInMonth = new Date(year, month, 0).getDate();
                    const firstDay = new Date(year, month - 1, 1).getDay();

                    const weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                    const headerRow = document.createElement('div');
                    headerRow.className = 'week-days';
                    weekDays.forEach(day => {
                        const dayElement = document.createElement('div');
                        dayElement.textContent = day;
                        headerRow.appendChild(dayElement);
                    });
                    calendarBody.appendChild(headerRow); // Append week days to calendar body

                    let date = 1;
                    for (let i = 0; i < 6; i++) {
                        const weekRow = document.createElement('div');
                        weekRow.className = 'days';
                        for (let j = 0; j < 7; j++) {
                            const dayElement = document.createElement('div');
                            if (i === 0 && j < firstDay) {
                                dayElement.textContent = '';
                            } else if (date > daysInMonth) {
                                break;
                            } else {
                                const dateCheck = new Date(year, month - 1, date);
                                dayElement.textContent = date;
                                dayElement.id = `day-\${year}-\${month}-\${date}`;
                                if (dateCheck >= today) {
                                    dayElement.addEventListener('click', function () {
                                        selectDate(`\${year}-\${month}-\${this.textContent}`);
                                    });
                                } else {
                                    dayElement.style.color = '#ccc';
                                }
                                date++;
                            }
                            weekRow.appendChild(dayElement);
                        }
                        calendarBody.appendChild(weekRow);
                        if (date > daysInMonth) {
                            break;
                        }
                    }

                    container.appendChild(calendarBody);
                }

                function setupNavigation() {
                    let currentYear = new Date().getFullYear();
                    let currentMonth = new Date().getMonth() + 1;

                    createCalendar("calendar1", currentYear, currentMonth);
                    if (currentMonth === 12) {
                        createCalendar("calendar2", currentYear + 1, 1);
                    } else {
                        createCalendar("calendar2", currentYear, currentMonth + 1);
                    }

                    const prevMonthButton = document.getElementById('prevMonth');
                    const nextMonthButton = document.getElementById('nextMonth');

                    prevMonthButton.addEventListener('click', function () {
                        if (currentMonth === 1) {
                            currentYear--;
                            currentMonth = 12;
                        } else {
                            currentMonth--;
                        }
                        createCalendar("calendar1", currentYear, currentMonth);
                        if (currentMonth === 12) {
                            createCalendar("calendar2", currentYear + 1, 1);
                        } else {
                            createCalendar("calendar2", currentYear, (currentMonth % 12) + 1);
                        }
                    });

                    nextMonthButton.addEventListener('click', function () {
                        if (currentMonth === 12) {
                            currentYear++;
                            currentMonth = 1;
                        } else {
                            currentMonth++;
                        }
                        createCalendar("calendar1", currentYear, currentMonth);
                        if (currentMonth === 12) {
                            createCalendar("calendar2", currentYear + 1, 1);
                        } else {
                            createCalendar("calendar2", currentYear, (currentMonth % 12) + 1);
                        }
                    });
                }

                setupNavigation();

                document.getElementById('submitDate').addEventListener('click', function (event) {
                    if (!selectedDates.start || !selectedDates.end) {
                        alert("날짜를 선택해주세요.");
                        event.preventDefault();
                        return;
                    }

                    document.getElementById('startDate').value = selectedDates.start.toISOString().split('T')[0];
                    document.getElementById('endDate').value = selectedDates.end.toISOString().split('T')[0];
                    document.getElementById('dateForm').submit();
                });

            </script>
        </body>