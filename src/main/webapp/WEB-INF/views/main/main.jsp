<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <style>
                #main {
                    width: 100%;
                    height: 40vh;
                    position: relative;
                    /* 백그라운드이미지 c:url 사용해서 넣기 */
                    background: url("<c:url value='/resources/images/img/ggg.png'/>") center center;
                    background-size: cover;
                    position: relative;
                }

                #main:before {
                    content: "";
                    background: rgba(255, 255, 255, 0.8);
                    position: absolute;
                    bottom: 0;
                    top: 0;
                    left: 0;
                    right: 0;
                }

                /* 사용함 */
                #main .container {
                    padding-top: 80px;
                    padding-bottom: 80px;
                }

                /* 사용함 */
                #main h1 {
                    margin: 0;
                    font-size: 56px;
                    font-weight: 700;
                    line-height: 72px;
                    color: #124265;
                    font-family: "Poppins", sans-serif;
                }

                /* 사용함 */
                #main .btn-get-started {
                    font-family: "Poppins", sans-serif;
                    font-weight: 500;
                    font-size: 14px;
                    letter-spacing: 0.5px;
                    display: inline-block;
                    padding: 14px 50px;
                    border-radius: 5px;
                    transition: 0.5s;
                    margin-top: 30px;
                    margin-bottom: 30px;
                    color: #000000;

                    /* 배경 투명하게 하기 */
                    background: #ffffff;

                    border: 1px solid #000000;
                }

                /* 사용함 */
                #main .btn-get-started:hover {
                    background: #000000;
                    color: #ffffff;
                }


                @media (min-width: 1024px) {
                    #main {
                        background-attachment: fixed;
                    }
                }

                @media (max-height: 800px) {
                    #main {
                        height: auto;
                    }
                }

                @media (max-width: 992px) {
                    #main {
                        height: auto;
                    }

                    #main h1 {
                        font-size: 28px;
                        line-height: 36px;
                    }

                    #main h2 {
                        font-size: 18px;
                        line-height: 24px;
                    }
                }
            </style>

        </head>

        <body>
            <section id="main" class="d-flex">
                <div class="container-fluid position-relative" data-aos="fade-up" data-aos-delay="100">
                    <div class="row justify-content-center">
                        <div class="col-xl-7 col-lg-9 text-center">
                            <h1>TRAVEL PLANNING</h1>
                            <h1>ASSISTANT</h1>
                        </div>
                    </div>
                    <div class="text-center ">
                        <a href="<c:url value='/planning/selecttheme'/>" class="btn-get-started scrollto">일정 만들기</a>
                    </div>

                </div>
            </section>
        </body>

        </html>