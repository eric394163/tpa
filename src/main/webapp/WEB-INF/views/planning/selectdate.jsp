<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Calendar</title>
<style>
    /* Basic styling */
    .calendar-navigation {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .calendar-container {
        display: inline-block;
        margin: 5px;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        user-select: none;
    }

    .header, .week-days, .days {
        display: flex;
    }

    .header div, .week-days div, .days div {
        width: 30px;
        height: 30px;
        line-height: 30px;
        text-align: center;
    }

    .week-days div {
        font-weight: bold;
    }

    .days div {
        cursor: pointer;
    }

    .days div:hover {
        background-color: #eee;
    }

    .selected {
        background-color: #add8e6;
        border-radius: 15px; /* Make it circular */
    }

    #prevMonth, #nextMonth {
        background-color: #f0f0f0;
        border: none;
        font-size: 24px;
        cursor: pointer;
    }

    #submitDate {
        display: block;
        margin: 20px auto;
        padding: 10px 20px;
        background-color: #f0f0f0;
        border: none;
        cursor: pointer;
    }

    .month-header {
        text-align: center;
        margin-bottom: 10px;
        font-size: 20px;
        font-weight: bold;
    }
</style>
</head>
<body>
    <div class="calendar-navigation">
        <button id="prevMonth">&#60;</button>
        <div id="calendar1" class="calendar-container">
            <!-- Month header will be inserted here by JavaScript -->
        </div>
        <div id="calendar2" class="calendar-container">
            <!-- Month header will be inserted here by JavaScript -->
        </div>
        <button id="nextMonth">&#62;</button>
    </div>
    <button id="submitDate">Submit</button>

<script>
function createCalendar(containerId, year, month) {
    const container = document.getElementById(containerId);
    container.innerHTML = ''; // Clear previous contents

    // Create and insert the month header
    const monthHeader = document.createElement('div');
    monthHeader.className = 'month-header';
    const monthNames = ["January", "February", "March", "April", "May", "June", 
                        "July", "August", "September", "October", "November", "December"];
    monthHeader.textContent = `\${monthNames[month - 1]} \${year}`;
    container.appendChild(monthHeader);

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
    container.appendChild(headerRow);

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
                dayElement.textContent = date;
                dayElement.id = `day-\${containerId}-\${date}`;
                dayElement.addEventListener('click', function() {
                    document.querySelectorAll('.selected').forEach(el => el.classList.remove('selected'));
                    this.classList.add('selected');
                });
                date++;
            }
            weekRow.appendChild(dayElement);
        }
        container.appendChild(weekRow);
        if (date > daysInMonth) {
            break;
        }
    }
}

function setupNavigation() {
    let currentYear = new Date().getFullYear();
    let currentMonth = new Date().getMonth() + 1; // JavaScript months are 0-indexed

    createCalendar("calendar1", currentYear, currentMonth);
    createCalendar("calendar2", currentYear, currentMonth + 1);

    const prevMonthButton = document.getElementById('prevMonth');
    const nextMonthButton = document.getElementById('nextMonth');

    prevMonthButton.addEventListener('click', function() {
        if (currentMonth === 1) {
            currentYear--;
            currentMonth = 12;
        } else {
            currentMonth--;
        }
        createCalendar("calendar1", currentYear, currentMonth);
        createCalendar("calendar2", currentYear, currentMonth === 12 ? 1 : currentMonth + 1);
    });

    nextMonthButton.addEventListener('click', function() {
        if (currentMonth === 12) {
            currentYear++;
            currentMonth = 1;
        } else {
            currentMonth++;
        }
        createCalendar("calendar1", currentYear, currentMonth);
        createCalendar("calendar2", currentYear, currentMonth === 12 ? 1 : currentMonth + 1);
    });
}

setupNavigation();

</script>
</body>
</html>
