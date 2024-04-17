
package kr.kh.spring.controller;

import java.util.Collections;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.PostMapping;

import kr.kh.spring.model.dto.LoginDTO;

import kr.kh.spring.model.dto.SignupDTO;
import kr.kh.spring.model.vo.UserVO;
import kr.kh.spring.service.UserService;
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

        return "/common/message";
    }

    @PostMapping("/id/check")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> IdCheck(@RequestParam String id) {
        boolean isAvailable = userService.checkId(id);
        System.out.println(isAvailable);
        return ResponseEntity.ok(Collections.singletonMap("isAvailable", isAvailable));
    }

    @PostMapping("/email/check")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> EmailCheck(@RequestParam String email) {
        boolean isAvailable = userService.checkEmail(email);
        System.out.println(isAvailable);
        return ResponseEntity.ok(Collections.singletonMap("isAvailable", isAvailable));
    }

    //닉네임중복체크
    @PostMapping("/nickname/check")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> NicknameCheck(@RequestParam String nickname) {
        boolean isAvailable = userService.checkNickname(nickname);
        System.out.println(isAvailable);
        return ResponseEntity.ok(Collections.singletonMap("isAvailable", isAvailable));
    }

}
