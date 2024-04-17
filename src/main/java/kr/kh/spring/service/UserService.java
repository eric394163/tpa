package kr.kh.spring.service;

import org.springframework.stereotype.Service;

import kr.kh.spring.model.dto.LoginDTO;
import kr.kh.spring.model.dto.SignupDTO;
import kr.kh.spring.model.vo.UserVO;

@Service
public interface UserService {

    UserVO login(LoginDTO loginDTO);

    boolean signup(SignupDTO signupDTO);

    boolean checkId(String id);

}
