package kr.kh.spring.dao;

import org.apache.ibatis.annotations.Param;

import kr.kh.spring.model.vo.UserVO;

public interface UserDAO {

    UserVO selectUser(@Param("user_id") String i_Id);

    boolean insertMember(@Param("user") UserVO user);

}
