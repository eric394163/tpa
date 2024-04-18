<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <head>
            <style>
                .theme-card {
                    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
                    transition: 0.3s;
                    width: 40%;
                    border-radius: 5px;
                    display: inline-block;
                    margin: 16px;
                }

                .theme-card:hover {
                    box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
                }

                .container {
                    padding: 2px 16px;
                }

                .theme-image {
                    width: 100%;
                    border-top-left-radius: 5px;
                    border-top-right-radius: 5px;
                    height: auto;
                }

                .theme-name {
                    font-size: 22px;
                    color: #333;
                }

                .button {
                    background-color: #ffffff;
                    /* Green */
                    border: none;
                    color: rgb(0, 0, 0);
                    padding: 6px 16px;
                    text-align: center;

                    text-decoration: none;
                    display: inline-block;
                    font-size: 16px;
                    margin: 4px 2px;
                    cursor: pointer;
                    border-radius: 10px;
                    border: 1px solid #333;

                }

                .select-button {
                    text-align: center;
                }

                @media (max-width: 767px) {
                    .box-container {
                        flex-direction: column;
                        align-items: center;
                    }

                    .theme-card {
                        width: 80%;
                        /* Larger percentage for smaller screens */
                    }
                }

                .box-container {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    align-content: center;
                }
            </style>
        </head>

        <body>
            <div class="container mt-4">
                <h2 style="text-align: center;"><span
                        style="border: #333 solid 1px; border-radius: 10px; padding: 5px">테마
                        선택</span></h2>
            </div>

<<<<<<< HEAD

=======
            <hr>
>>>>>>> develop

            <div class="row">
                <div class="col-2">
                    ${themeList}
                </div>
                <div class="col-8">
<<<<<<< HEAD
                    <hr>
                    <div class="box-container mt-3" style="display: flex;">
                        <c:forEach items="${themeList}" var="theme" begin="0" end="2">
                            <div class="theme-card">
                                <img src="<c:url value='${theme.theme_imgUrl}'/>" width="100%" alt="${theme.theme_name}"
                                    class="theme-image">
                                <div class="container">
                                    <h4 class="theme-name"><b>${theme.theme_name}</b></h4>
                                    <div class="select-button">
                                        <c:url var="url" value="/planning/selectregion">
                                            <c:param name="theme_NUM" value="${theme.theme_NUM}" />
                                        </c:url>
                                        <a href="${url}" class="button">선택하기</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="box-container mt-3" style="display: flex;">
                        <c:forEach items="${themeList}" var="theme" begin="3" end="5">
                            <div class="theme-card">
                                <img src="<c:url value='${theme.theme_imgUrl}'/>" width="100%" alt="${theme.theme_name}"
                                    class="theme-image">
                                <div class="container">
                                    <h4 class="theme-name"><b>${theme.theme_name}</b></h4>
                                    <div class="select-button">
                                        <c:url var="url" value="/planning/selectregion">
                                            <c:param name="theme_NUM" value="${theme.theme_NUM}" />
                                        </c:url>
                                        <a href="${url}" class="button">선택하기</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <div class="box-container mt-3" style="display: flex;">
                        <c:forEach items="${themeList}" var="theme" begin="6" end="8">
                            <div class="theme-card">
                                <img src="<c:url value='${theme.theme_imgUrl}'/>" width="100%" alt="${theme.theme_name}"
                                    class="theme-image">
                                <div class="container">
                                    <h4 class="theme-name"><b>${theme.theme_name}</b></h4>
                                    <div class="select-button">
                                        <c:url var="url" value="/planning/selectregion">
                                            <c:param name="theme_NUM" value="${theme.theme_NUM}" />
                                        </c:url>
                                        <a href="${url}" class="button">선택하기</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
=======
                    <div class="box-container" style="display: flex;">
                        <div class="theme-card">
                            <img src="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"
                                alt="Theme Name" class="theme-image">
                            <div class="container">
                                <h4 class="theme-name"><b>Theme Name</b></h4>
                                <div class="select-button">
                                    <a href="#" class="button">선택하기</a>
                                </div>
                            </div>
                        </div>
                        <div class="theme-card">
                            <img src="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"
                                alt="Theme Name" class="theme-image">
                            <div class="container">
                                <h4 class="theme-name"><b>Theme Name</b></h4>
                                <div class="select-button">
                                    <a href="#" class="button">선택하기</a>
                                </div>
                            </div>
                        </div>
                        <div class="theme-card">
                            <img src="https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"
                                alt="Theme Name" class="theme-image">
                            <div class="container">
                                <h4 class="theme-name"><b>Theme Name</b></h4>
                                <div class="select-button">
                                    <a href="#" class="button">선택하기</a>
                                </div>
                            </div>
                        </div>
>>>>>>> develop
                    </div>
                </div>
                <div class="col-2">
                </div>
            </div>


        </body>