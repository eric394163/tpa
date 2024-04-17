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

    // 로그인
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


    // 회원가입
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


    // 아이디 중복확인
    @Override
    public boolean checkId(String id) {
        UserVO user = userDAO.selectUserById(id);
        if (user != null) {
            return false;
        }
        return true;

    }

    // 이메일 중복확인
    @Override
    public boolean checkEmail(String email) {
        UserVO user = userDAO.selectUserByEmail(email);
        if (user != null) {
            return false;
        }
        return true;

    }

    //닉네임 중복 확인
    @Override
    public boolean checkNickname(String nickname) {
        UserVO user = userDAO.selectUserByNickname(nickname);
        if (user != null) {
            return false;
        }
        return true;


    }

}
