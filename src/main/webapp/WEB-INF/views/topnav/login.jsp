<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <head>
            <style>
                /* body {
            background: #007bff;
            background: linear-gradient(to right, #0062E6, #33AEFF);
        } */

                .btn-login {
                    font-size: 0.9rem;
                    letter-spacing: 0.05rem;
                    padding: 0.75rem 1rem;
                    color: rgb(0, 0, 0);
                    background-color: #ffffff;
                }

                .btn-login:hover {
                    color: #ffffff;
                    background-color: #000000;
                    text-decoration: none;
                }

                .btn-google {
                    color: white !important;
                    background-color: #ea4335;
                }

                .btn-facebook {
                    color: white !important;
                    background-color: #3b5998;
                }
            </style>
        </head>

        <body>
            <div class="container">
                <div class="row">
                    <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
                        <div class="card border-0 shadow rounded-3 my-5">
                            <div class="card-body p-4 p-sm-5">
                                <h5 class="card-title text-center mb-5 fw-light fs-5">Sign In</h5>
                                <form action="<c:url value='/login'/>" method="post">
                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="id" name="id" placeholder="id"
                                            required>
                                        <label for="floatingInput">아이디</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="password" class="form-control" id="pw" name="pw"
                                            placeholder="password" required>
                                        <label for="floatingPassword">비밀번호</label>
                                    </div>


                                    <!-- <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" value="" id="rememberPasswordCheck">
                                <label class="form-check-label" for="rememberPasswordCheck">
                                    Remember password
                                </label>
                            </div> -->
                                    <div class="d-grid">
                                        <button class="btn-login btn-primary btn-login text-uppercase fw-bold"
                                            type="submit">Signin
                                        </button>
                                    </div>
                                    <hr class="my-4">
                                    <!-- <div class="d-grid mb-2">
                                        <button class="btn btn-google btn-login text-uppercase fw-bold" type="submit">
                                            <i class="fab fa-google me-2"></i> Sign in with Google
                                        </button>
                                    </div>
                                    <div class="d-grid">
                                        <button class="btn btn-facebook btn-login text-uppercase fw-bold" type="submit">
                                            <i class="fab fa-facebook-f me-2"></i> Sign in with Facebook
                                        </button>
                                    </div> -->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>