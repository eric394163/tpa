package kr.kh.spring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.spring.model.vo.RegionVO;
import kr.kh.spring.model.vo.ThemeVO;

public interface TravelInfoDAO {

    // 테마 관련 메서드
    ArrayList<ThemeVO> selectThemeList();

    ArrayList<RegionVO> selectRegionList(@Param("division_NUM") int division_NUM);

    int selectTotalDivisionCount();

}
