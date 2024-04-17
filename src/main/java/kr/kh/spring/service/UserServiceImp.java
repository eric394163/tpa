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

    @Override
    public UserVO login(LoginDTO loginDTO) {
        // 매개변수 null 처리
        if (loginDTO == null ||
                loginDTO.getId() == null ||
                loginDTO.getPw() == null)
            return null;
        String i_Id = loginDTO.getId();

        // 아이디 확인
        UserVO user = userDAO.selectUser(i_Id);
        if (user == null) {
            return null;
        }

        if (passwordEncoder.matches(loginDTO.getPw(), user.getUser_pw())) {
            return user;
        }
        return user;

    }

    @SuppressWarnings("null")
    @Override
    public boolean signup(SignupDTO signupDTO) {

        if (signupDTO == null) {
            return false;
        }

        String i_id = signupDTO.getId();
        // 아이디 중복 확인
        UserVO user = userDAO.selectUser(i_id);

        System.out.println("user : " + user);

        // 이미 가입된 아이디
        if (user != null) {
            return false;
        }

        // 빈 문자열도 암호화를 적용하면 빈문자열이 아니기 때문에 가입이 될 수 있어서 처리
        if (user.getUser_pw() == null || user.getUser_pw().length() == 0) {
            return false;
        }

        // 비밀번호 암호화
        String encodePw = passwordEncoder.encode(user.getUser_pw());

        user.setUser_pw(encodePw);
        try {
            return userDAO.insertMember(user);
        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean checkId(String id) {
        UserVO user = userDAO.selectUser(id);
        if (user != null) {
            return false;
        }
        return true;

    }

}
