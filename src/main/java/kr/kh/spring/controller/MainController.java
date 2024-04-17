
package kr.kh.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {

    // value : url, method : 전송박식을 GET 또는 POST
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Model model) {

        return "/main/home";
    }

    @GetMapping("/login")
    public String login(Model model) {
        return "/topnav/login";
    }

    @GetMapping("/signup")
    public String signUp(Model model) {
        return "/topnav/signup";
    }

}
