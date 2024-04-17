package kr.kh.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.kh.spring.dao.UserDAO;
import kr.kh.spring.model.dto.LoginDTO;
import kr.kh.spring.model.dto.SignupDTO;
import kr.kh.spring.model.vo.UserVO;

@Service
public class UserServiceImp implements UserService {

    @Autowired
    BCryptPasswordEncoder passwordEncoder;

    @Autowired
    UserDAO userDAO;

    // ================= 로그인 시작 =================

    // - 함수명 : login
    // - 매개변수 : loginDTO
    // - 기능 : 로그인
    // - 상세 : 아이디와 비밀번호를 확인하여 로그인한다.
    @Override
    public UserVO login(LoginDTO loginDTO) {
        // 매개변수 null 처리
        if (loginDTO == null ||
                loginDTO.getId() == null ||
                loginDTO.getPw() == null)
            return null;
        String i_Id = loginDTO.getId();

        // 아이디 확인
        UserVO user = userDAO.selectUserById(i_Id);
        if (user == null) {
            return null;
        }

        if (passwordEncoder.matches(loginDTO.getPw(), user.getUser_pw())) {
            return user;
        }
        return user;

    }

    // ================= 로그인 끝 =================

    // ================= 회원가입 시작 =================

    // - 함수명 : signup
    // - 매개변수 : signupDTO
    // - 기능 : 회원가입
    // - 상세 : signupDTO를 받아 비밀번호를 암호화하고 newUser에 담아 insertUser를 실행한다.
    @SuppressWarnings("null")
    @Override
    public boolean signup(SignupDTO signupDTO) {

        if (signupDTO == null || signupDTO.getPw() == null || signupDTO.getPw().isEmpty()) {
            return false;
        }

        UserVO existingUser = userDAO.selectUserById(signupDTO.getId());
        if (existingUser != null) {
            return false;
        }

        String encryptedPassword = passwordEncoder.encode(signupDTO.getPw());

        UserVO newUser = new UserVO();
        newUser.setUser_id(signupDTO.getId());
        newUser.setUser_email(signupDTO.getEmail());
        newUser.setUser_nickname(signupDTO.getNickname());
        newUser.setUser_pw(encryptedPassword);
        // newUser.setUser_imgUrl(signupDTO.getImgUrl());
        // newUser.setUser_state("사용중");
        // newUser.setUser_role("사용자");
        // newUser.setUser_content("");
        try {
            return userDAO.insertUser(newUser);
        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    // - 함수명 : checkId
    // - 매개변수 : id
    // - 기능 : 아이디 중복확인
    // - 상세 : id를 받아 selectUserById를 실행하여 결과가 없으면 true를 반환한다.
    @Override
    public boolean checkId(String id) {
        UserVO user = userDAO.selectUserById(id);
        if (user != null) {
            return false;
        }
        return true;

    }

    // - 함수명 : checkEmail
    // - 매개변수 : email
    // - 기능 : 이메일 중복확인
    // - 상세 : email을 받아 selectUserByEmail를 실행하여 결과가 없으면 true를 반환한다.
    @Override
    public boolean checkEmail(String email) {
        UserVO user = userDAO.selectUserByEmail(email);
        if (user != null) {
            return false;
        }
        return true;

    }

    // - 함수명 : checkNickname
    // - 매개변수 : nickname
    // - 기능 : 닉네임 중복확인
    // - 상세 : nickname을 받아 selectUserByNickname를 실행하여 결과가 없으면 true를 반환한다.
    @Override
    public boolean checkNickname(String nickname) {
        UserVO user = userDAO.selectUserByNickname(nickname);
        if (user != null) {
            return false;
        }
        return true;

    }

    // ================= 회원가입 끝 =================

}
