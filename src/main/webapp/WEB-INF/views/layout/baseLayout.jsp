<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!doctype html>
            <html>

            <head>
                <title>
                    <c:choose>
                        <c:when test="${title != null }">${title}</c:when>
                        <c:otherwise>스프링</c:otherwise>
                    </c:choose>
                </title>

                <!-- Latest compiled and minified CSS -->
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

                <!-- jQuery library -->
                <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

                <!-- Popper JS -->
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
                <style>
                    body {
                        min-width: 500px;
                    }

                    h1,
                    h2,
                    h3,
                    h4,
                    h5,
                    h6 {
                        font-family: "Raleway", sans-serif;
                    }
                </style>
            </head>

            <body>
                <tiles:insertAttribute name="header" />
                <div style="min-height: calc(100vh - 290px)">
                    <tiles:insertAttribute name="body" />
                </div>
                <tiles:insertAttribute name="footer" />

                <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
                        class="bi bi-arrow-up-short"></i></a>


                <script>

                    (function () {
                        "use strict";

                        /**
                         * Easy selector helper function
                         */
                        const select = (el, all = false) => {
                            el = el.trim()
                            if (all) {
                                return [...document.querySelectorAll(el)]
                            } else {
                                return document.querySelector(el)
                            }
                        }

                        /**
                         * Easy on scroll event listener 
                         */
                        const onscroll = (el, listener) => {
                            el.addEventListener('scroll', listener)
                        }
                        /**
                         * Back to top button
                         */
                        let backtotop = select('.back-to-top')
                        if (backtotop) {
                            const toggleBacktotop = () => {
                                if (window.scrollY > 100) {
                                    backtotop.classList.add('active')
                                } else {
                                    backtotop.classList.remove('active')
                                }
                            }
                            window.addEventListener('load', toggleBacktotop)
                            onscroll(document, toggleBacktotop)
                        }


                    })()
                </script>
            </body>

            </html>