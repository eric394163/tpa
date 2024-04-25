<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <style>
            #header {
                transition: all 0.5s;
                background: #ffffff;
                z-index: 997;
                padding: 15px 0;
                border-bottom: 1px solid #ffffff;
            }

            #header.header-scrolled {
                border-color: #fff;
                box-shadow: 0px 2px 15px rgba(18, 66, 101, 0.08);
            }

            .navbar {
                padding: 0;
            }

            .navbar ul {
                margin: 0;
                padding: 0;
                display: flex;
                list-style: none;
                align-items: center;
            }

            .navbar li {
                position: relative;
            }

            .navbar .btn,
            .navbar .btn:focus {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 10px 0 10px 30px;
                font-size: 17px;
                color: #040404;
                white-space: nowrap;
                transition: 0.3s;
            }

            .navbar .btn i,
            .navbar .btn:focus i {
                font-size: 12px;
                line-height: 0;
                margin-left: 5px;
            }

            .navbar .btn:hover,
            .navbar .active,
            .navbar .active:focus,
            .navbar li:hover>a {
                color: #ffffff,
            }

            .navbar .btn,
            .navbar .btn:focus {
                background: #ffffff;
                padding: 8px 20px;
                margin-left: 30px;
                border-radius: 4px;
                color: #000000;
            }

            .navbar .btn:hover,
            .navbar .btn:focus:hover {
                color: #ffffff;
                background: #000000;
            }

            .btn {
                color: #000000;
                text-decoration: none;
                /*테두리 둘러싸기*/
                border: 2px solid #000000;
            }

            .btn:hover {
                color: #ffffff;
                background-color: #000000;
                text-decoration: none;
            }

            .header-hr {
                border: none;
                /* 기본 테두리 제거 */
                height: 1px;
                /* 줄 높이 설정 */
                background-color: #ccc;
                /* 줄의 색상 설정 */
                box-shadow: 2px 2px 4px #888888;
                /* 그림자 효과 추가 */
            }

            .logo {
                margin-right: auto;
            }

            .container {
                margin: 0px;

            }
        </style>

        <div class="header-container-fluid d-flex align-items-center justify-content-between ">
            <a class="logo" href="<c:url value='/'/>">
                <img src="<c:url value='/resources/images/logo/TRAVELPLANNINGASSISTANT_LOGO.jpg'/>"
                    style="width: 200px;">
            </a>

            <nav id="navbar" class="navbar">
                <ul>
                    <c:if test="${user == null }">
                        <li><a class="btn " href="<c:url value='/login'/>">로그인</a></li>
                        <li><a class="btn " href="<c:url value='/signup'/>">회원가입</a></li>
                    </c:if>
                    <c:if test="${user != null }">
                        <li><a class="btn" href="<c:url value='/mypage'/>">마이페이지</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <hr class="header-hr">