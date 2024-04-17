<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <style>
            /*--------------------------------------------------------------
# Footer
--------------------------------------------------------------*/
            #footer {
                color: #444444;
                font-size: 14px;
                background: #f8fbfe;
                box-shadow: 0px 2px 15px rgba(18, 66, 101, 0.08);
            }

            #footer .footer-top {
                padding: 60px 0 30px 0;
                background: #fff;
            }

            #footer .footer-top .footer-contact {
                margin-bottom: 30px;
            }

            #footer .footer-top .footer-contact h3 {
                font-size: 26px;
                margin: 0 0 10px 0;
                padding: 2px 0 2px 0;
                line-height: 1;
                font-weight: 300;
            }

            #footer .footer-top .footer-contact p {
                font-size: 14px;
                line-height: 24px;
                margin-bottom: 0;
                font-family: "Raleway", sans-serif;
                color: #777777;
            }

            #footer .footer-top h4 {
                font-size: 16px;
                font-weight: bold;
                color: #323232;
                position: relative;
                padding-bottom: 12px;
            }

            #footer .footer-top .footer-links {
                margin-bottom: 30px;
            }

            #footer .footer-top .footer-links ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            #footer .footer-top .footer-links ul i {
                padding-right: 2px;
                color: #2487ce;
                font-size: 18px;
                line-height: 1;
            }

            #footer .footer-top .footer-links ul li {
                padding: 10px 0;
                display: flex;
                align-items: center;
            }

            #footer .footer-top .footer-links ul li:first-child {
                padding-top: 0;
            }

            #footer .footer-top .footer-links ul a {
                color: #777777;
                transition: 0.3s;
                display: inline-block;
                line-height: 1;
            }

            #footer .footer-top .footer-links ul a:hover {
                text-decoration: none;
                color: #2487ce;
            }



            #footer .credits {
                padding-top: 5px;
                font-size: 13px;
                color: #444444;
            }

            #footer .social-links a {
                font-size: 18px;
                display: inline-block;
                background: #2487ce;
                color: #fff;
                line-height: 1;
                padding: 8px 0;
                margin-right: 4px;
                border-radius: 5px;
                text-align: center;
                width: 36px;
                height: 36px;
                transition: 0.3s;
            }

            #footer .social-links a:hover {
                background: #3194db;
                color: #fff;
                text-decoration: none;
            }
        </style>
        <footer id="footer">

            <div class="footer-top">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4  footer-contact">
                            <h3>TPA</h3>
                            <p>
                                A108 Adam Street <br>
                                New York, NY 535022<br>
                                United States <br><br>
                                <strong>Phone:</strong> +81 9999 9999<br>
                                <strong>Email:</strong> eric394163@gmail.com<br>
                            </p>
                        </div>

                        <div class="col-lg-4  footer-links">
                            <h4>Useful Links</h4>
                            <ul>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Home</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">About us</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Services</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Terms of service</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Privacy policy</a></li>
                            </ul>
                        </div>

                        <div class="col-lg-4 footer-links">
                            <h4>Our Services</h4>
                            <ul>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Web Design</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Web Development</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Product Management</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>
                                <li><i class="bx bx-chevron-right"></i> <a href="#">Graphic Design</a></li>
                            </ul>
                        </div>

                    </div>
                </div>
            </div>

            <div class="container">
                <div class="me-md-auto text-center text-md-start">
                    <div class="copyright">
                        &copy; Copyright <strong><span>TPA</span></strong>. All Rights Reserved
                    </div>
                    <div class="credits">
                        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
                    </div>
                </div>
            </div>
        </footer>