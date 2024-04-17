<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!-- jQuery Validation  -->
        <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/additional-methods.min.js"></script>
        <style>
            .main-contents .login-form {
                width: 560px;
                margin: 0 auto;
                border: 1px solid #000000;
                border-radius: 10px;

            }

            .main-contents .login-form p {
                margin-bottom: 30px;
                font-size: 14px;
                text-align: center;
            }

            .main-contents .form-group {
                position: relative;
                margin-bottom: 20px;
                padding: 0 50px;
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                align-items: center;
            }

            .main-contents .form-group label:first-child {
                width: 140px;
            }

            .main-contents .form-group label.error {
                font-size: 12px;
                color: red;
            }

            .main-contents .form-group .form-control {
                width: 320px;
            }

            .main-contents .form-actions {
                display: flex;
                justify-content: center;
                margin-top: 50px;
                padding: 0 50px;
            }

            .main-contents .form-actions .btn {
                display: block;
                width: 100%;
                padding: 10px;
            }
        </style>
        </head>

        <div class="container fluid mt-3">
            <div class="row">
                <div class="col-2">
                </div>
                <div class="col-8">
                    <div class="main-contents">
                        <div class="login-form">
                            <div class="login_title_wrap">
                                <h2 class="mb-3, mt-3" style="text-align: center; ">회원가입</h2>

                            </div>
                            <form action="<c:url value='/signup'/>" method="post" id="signupForm">
                                <div class="form-group">
                                    <label for="id">아이디:</label>
                                    <input type="text" class="form-control" id="id" name="id" required />
                                    <label id="id-error2" class="error"></label>
                                </div>
                                <div class="form-group">
                                    <label for="email">이메일:</label>
                                    <input type="text" class="form-control" id="email" name="email" required />
                                    <label id="id-error3" class="error"></label>
                                </div>
                                <div class="form-group">
                                    <label for="pw">비밀번호:</label>
                                    <input type="password" class="form-control" id="pw" name="pw" required />
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">비밀번호 확인:</label>
                                    <input type="password" class="form-control" id="confirmPassword"
                                        name="confirmPassword" required />
                                </div>
                                <div class="form-group">
                                    <label for="nickname">닉네임:</label>
                                    <input type="text" class="form-control" id="nickname" name="nickname" required />
                                    <label id="id-error4" class="error"></label>
                                </div>

                                <div class="form-actions">
                                    <button type="submit" class="btn btn-dark mb-3">가입하기</button>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
                <div class="col-2">
                </div>
            </div>
        </div>





        <script type="text/javascript">
            $(document).ready(function () {
                $("#signupForm").validate({ // form id 확인 
                    rules: {
                        id: {
                            required: true
                            //regex: /^\w{6,12}$/,
                        },
                        email: {
                            required: true,
                            //regex: /[a-z0-9]+@[a-z]+\.[a-z]{2,3}/
                        },
                        pw: {
                            required: true,
                            regex: /^[a-zA-Z0-9!@#]{6,15}$/,
                        },
                        confirmPassword: {
                            equalTo: "#pw",
                            required: true,
                        },
                        nickname: {
                            required: true,
                            regex: /^[a-zA-Z0-9가-힣_]{2,10}$/,
                        },

                    },
                    messages: {
                        id: {
                            required: "필수 항목입니다."
                            //regex: "아이디는 6~12자의 영문 대소문자와 숫자로만 구성해야 합니다.",
                        },
                        email: {
                            required: "필수 항목입니다.",
                            //email: "올바른 이메일 주소를 입력해주세요.",
                        },
                        pw: {
                            required: "필수 항목입니다.",
                            regex:
                                "비밀번호는 6~15자의 영문 대소문자, 숫자, 특수문자(!@#)로만 구성해야 합니다.",
                        },
                        confirmPassword: {
                            equalTo: "입력하신 비밀번호와 일치해야 합니다.",
                            required: "필수 항목입니다.",
                        },
                        nickname: {
                            required: "필수 항목입니다.",
                            // regex:
                            //     "닉네임은 2~10자의 영문 대소문자, 숫자, 한글, 밑줄(_)로만 구성해야 합니다.",
                        },
                    },
                });

                $.validator.addMethod(
                    "regex",
                    function (value, element, regexp) {
                        var re = new RegExp(regexp);
                        return this.optional(element) || re.test(value);
                    },
                    "정규표현식에 맞지 않습니다."
                );
            });
        </script>

        <!-- 아이디 중복관련 -->
        <script type="text/javascript">
            let flag1 = false;
            $('[name=id]').on('input', function () {
                $('#id-error2').text("");
                $('#id-error2').hide();

                let id = $(this).val();

                if (id == '') {
                    $('#id-error2').text('아이디를 입력하세요.');
                    $('#id-error2').css('color', 'red');
                    $('#id-error2').show();
                    return;
                }
                let idRegex = /^\w{6,12}$/;
                if (!idRegex.test(id)) {
                    $('#id-error2').text('아이디는 6~12자의 영문 대소문자와 숫자로만 구성해야 합니다.');
                    $('#id-error2').css('color', 'red');
                    $('#id-error2').show();
                    return;
                }


                $.ajax({
                    url: "<c:url value='/id/check'/>",
                    method: 'post',
                    async: true,
                    data: { 'id': id },
                    headers: {
                        'Accept': 'application/json',  // Explicitly accept JSON
                    },
                    success: function (response) {
                        console.log(response.isAvailable);
                        if (response.isAvailable) {
                            $('#id-error2').text('사용 가능한 아이디입니다.').css('color', 'green').show();
                        } else {
                            $('#id-error2').text('이미 사용중인 아이디입니다.').css('color', 'red').show();
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log("AJAX Error:");
                        console.log("Status: ", status);
                        console.log("Error: ", error);
                        console.log("Server Response: ", xhr.responseText);
                    }

                });
            });


            $('[name=id]').change(function () {
                flag1 = false;
            });
        </script>

        <script type="text/javascript">
            let flagEmail = false;
            $('[name=email]').on('input', function () {
                $('#id-error3').text("");
                $('#id-error3').hide();

                let email = $(this).val();

                if (email === '') {
                    $('#id-error3').text('이메일을 입력하세요.');
                    $('#id-error3').css('color', 'red');
                    $('#id-error3').show();
                    return;
                }

                var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                if (!emailRegex.test(email)) {
                    $('#id-error3').text('올바른 형식의 이메일을 입력하세요.');
                    $('#id-error3').css('color', 'red');
                    $('#id-error3').show();
                    return;
                }

                $.ajax({
                    url: '<c:url value="/email/check"/>', // 서버 URL
                    method: 'post',  // HTTP 메서드를 POST로 변경
                    contentType: 'application/x-www-form-urlencoded', // 콘텐츠 타입 명시
                    data: { 'email': email }, // 전송할 데이터
                    success: function (response) {
                        if (response.isAvailable) {
                            $('#id-error3').text('사용 가능한 이메일입니다.');
                            $('#id-error3').css('color', 'green');
                            $('#id-error3').show();
                            flagEmail = true;
                        } else {
                            $('#id-error3').text('이미 사용중인 이메일입니다.');
                            $('#id-error3').css('color', 'red');
                            $('#id-error3').show();
                            flagEmail = false;
                        }
                    },
                    error: function () {
                        console.log('예외 발생');
                    }
                });
            });

            $('[name=email]').change(function () {
                flagEmail = false;
            });
        </script>

        <script type="text/javascript">
            let flagNickname = false;  // 닉네임 중복 검사 플래그
            $('[name=nickname]').on('input', function () {
                $('#id-error4').text("");
                $('#id-error4').hide();

                let nickname = $(this).val();

                if (nickname == '') {
                    $('#id-error4').text('닉네임을 입력하세요.');
                    $('#id-error4').css('color', 'red');
                    $('#id-error4').show();
                    return;
                }

                let nicknameRegex = /^[a-zA-Z0-9가-힣_]{2,10}$/;
                if (!nicknameRegex.test(nickname)) {
                    $('#id-error4').text('닉네임은 2~10자의 영문 대소문자, 숫자, 한글, 밑줄(_)로만 구성해야 합니다.');
                    $('#id-error4').css('color', 'red');
                    $('#id-error4').show();
                    return;
                }

                $.ajax({
                    url: "<c:url value='/nickname/check'/>",
                    method: 'post',
                    async: true,
                    data: { 'nickname': nickname },
                    headers: {
                        'Accept': 'application/json',  // Explicitly accept JSON
                    },
                    success: function (response) {
                        console.log(response.isAvailable);
                        if (response.isAvailable) {
                            $('#id-error4').text('사용 가능한 닉네임입니다.').css('color', 'green').show();
                            flagNickname = true;
                        } else {
                            $('#id-error4').text('이미 사용중인 닉네임입니다.').css('color', 'red').show();
                            flagNickname = false;
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log("AJAX Error:");
                        console.log("Status: ", status);
                        console.log("Error: ", error);
                        console.log("Server Response: ", xhr.responseText);
                    }
                });
            });
        </script>




        </body>