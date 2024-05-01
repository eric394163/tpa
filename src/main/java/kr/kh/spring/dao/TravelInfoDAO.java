package kr.kh.spring.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import kr.kh.spring.model.vo.DivisionVO;
import kr.kh.spring.model.vo.PlaceVO;
import kr.kh.spring.model.vo.ThemeVO;
import kr.kh.spring.pagination.PlaceCriteria;

public interface TravelInfoDAO {

    // 테마 관련 메서드
    ArrayList<ThemeVO> selectThemeList();

    // 지역 관련 메서드
    ArrayList<DivisionVO> selectDivisionList(@Param("theme_NUM") int theme_NUM);

    // 장소 관련 메서드
    ArrayList<PlaceVO> selectPlaceByRegionAndTheme(@Param("cri") PlaceCriteria cri);
    ArrayList<PlaceVO> selectPlaceByRegionAndThemeAndType(@Param("cri") PlaceCriteria cri);
    ArrayList<PlaceVO> selectPlaceByRegionAndThemeMost(@Param("cri") PlaceCriteria cri);

    ArrayList<PlaceVO> selectPlaceBySearch(@Param("cri") PlaceCriteria cri);

}
