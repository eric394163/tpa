package kr.kh.spring.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.spring.model.vo.UserVO;

public interface UserDAO {
    //유저 추가 메서드
    boolean insertUser(@Param("user") UserVO user);

    //중복확인 메서드
    UserVO selectUserByEmail(@Param("email") String email);
    UserVO selectUserById(@Param("id") String i_id);

}
