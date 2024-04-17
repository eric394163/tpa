
package kr.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TestController {

    // value : url, method : 전송박식을 GET 또는 POS

    @RequestMapping(value = "/testmap", method = RequestMethod.GET)
    public String testmap(Model model) {

        return "/test/testmap";
    }

    @RequestMapping(value = "/test", method = RequestMethod.GET)
    public String test(Model model) {

        return "/test/test";
    }

    



}
