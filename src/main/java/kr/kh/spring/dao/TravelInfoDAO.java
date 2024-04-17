package kr.kh.spring.dao;

import java.util.ArrayList;

import kr.kh.spring.model.vo.ThemeVO;

public interface TravelInfoDAO {

    // 테마 관련 메서드
    ArrayList<ThemeVO> selectThemeList();

}
