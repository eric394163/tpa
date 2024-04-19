package kr.kh.spring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.spring.model.vo.DivisionVO;
import kr.kh.spring.model.vo.ThemeVO;

public interface TravelInfoDAO {

    // 테마 관련 메서드
    ArrayList<ThemeVO> selectThemeList();

    ArrayList<DivisionVO> selectDivisionList(@Param("theme_NUM") int theme_NUM);

}
