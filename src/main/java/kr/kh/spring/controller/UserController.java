
package kr.kh.spring.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.spring.model.dto.LoginDTO;

import kr.kh.spring.model.dto.SignupDTO;
import kr.kh.spring.model.vo.UserVO;
import kr.kh.spring.service.UserService;
import kr.kh.spring.service.UserServiceImp;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class UserController {

    @Autowired
    UserService userService;

    @PostMapping("/login")
    public String loginPost(Model model, LoginDTO loginDTO) {
        System.out.println(loginDTO.getId() + " " + loginDTO.getPw());
        UserVO user = userService.login(loginDTO);

        model.addAttribute("user", user);
        if (user != null) {
            model.addAttribute("url", "/");
            model.addAttribute("msg", "로그인을 했습니다.");
        } else {
            model.addAttribute("url", "/login");
            model.addAttribute("msg", "로그인을 하지 못했습니다.");
        }
        return "message";
    }

    @PostMapping("/signup")
    public String signupPost(Model model, SignupDTO signupDTO) {
        System.out.println(signupDTO.getId() + " " + signupDTO.getPw());
        boolean res = userService.signup(signupDTO);
        if (res) {
            model.addAttribute("msg", "회원가입을 했습니다.");
            model.addAttribute("url", "/");
        } else {
            model.addAttribute("msg", "회원가입을 하지 못했습니다.");
            model.addAttribute("url", "/signup");
        }

        return "message";
    }

    @PostMapping("/id/check")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> IdCheck(@RequestParam String id) {
        boolean isAvailable = userService.checkId(id);
        return ResponseEntity.ok(Collections.singletonMap("isAvailable", isAvailable));
    }

}
