
package kr.kh.spring.controller;

import java.util.Collections;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
    UserService user_s;

    @GetMapping("/login")
    public String login(Model model) {
        return "/topnav/login";
    }

    // - 함 수 명 : loginPost
    // - 기 능 : 로그인
    // - 파 라 미 터 : model, loginDTO
    @PostMapping("/login")
    public String loginPost(Model model, LoginDTO loginDTO) {
        System.out.println(loginDTO.getId() + " " + loginDTO.getPw());
        UserVO user = user_s.login(loginDTO);

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

    @GetMapping("/signup")
    public String signUp(Model model) {
        return "/topnav/signup";
    }

    // - 함 수 명 : signupPost
    // - 기 능 : 회원가입
    // - 파 라 미 터 : model, signupDTO
    @PostMapping("/signup")
    public String signupPost(Model model, SignupDTO signupDTO) {
        System.out.println(signupDTO.getId() + " " + signupDTO.getPw());
        boolean res = user_s.signup(signupDTO);
        if (res) {
            model.addAttribute("msg", "회원가입을 했습니다.");
            model.addAttribute("url", "/");
        } else {
            model.addAttribute("msg", "회원가입을 하지 못했습니다.");
            model.addAttribute("url", "/signup");
        }

        return "/common/message";
    }

    // - 함 수 명 : IdCheck
    // - 기 능 : 아이디 중복체크
    // - 파 라 미 터 : id
    @PostMapping("/id/check")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> IdCheck(@RequestParam String id) {
        boolean isAvailable = user_s.checkId(id);
        System.out.println(isAvailable);
        return ResponseEntity.ok(Collections.singletonMap("isAvailable", isAvailable));
    }

    // - 함 수 명 : EmailCheck
    // - 기 능 : 이메일 중복체크
    // - 파 라 미 터 : email
    @PostMapping("/email/check")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> EmailCheck(@RequestParam String email) {
        boolean isAvailable = user_s.checkEmail(email);
        System.out.println(isAvailable);
        return ResponseEntity.ok(Collections.singletonMap("isAvailable", isAvailable));
    }

    // - 함 수 명 : NicknameCheck
    // - 기 능 : 닉네임 중복체크
    // - 파 라 미 터 : nickname
    @PostMapping("/nickname/check")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> NicknameCheck(@RequestParam String nickname) {
        boolean isAvailable = user_s.checkNickname(nickname);
        System.out.println(isAvailable);
        return ResponseEntity.ok(Collections.singletonMap("isAvailable", isAvailable));
    }

    // =================기능 관리 끝=================

}
