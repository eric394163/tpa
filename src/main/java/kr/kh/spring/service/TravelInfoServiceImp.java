package kr.kh.spring.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.spring.dao.TravelInfoDAO;
import kr.kh.spring.model.vo.DivisionVO;
import kr.kh.spring.model.vo.RegionVO;
import kr.kh.spring.model.vo.ThemeVO;

@Service
public class TravelInfoServiceImp implements TravelInfoService {

    @Autowired
    TravelInfoDAO travelInfoDAO;

    // - 함수명 : getThemeList
    // - 매개변수 : 없음
    // - 기능 : 테마 리스트를 가져온다.
    @Override
    public ArrayList<ThemeVO> getThemeList() {

        return travelInfoDAO.selectThemeList();

    }
    
    // - 함수명 : getDivision_Region
    // - 매개변수 : int theme_NUM
    // - 기능 : 테마에 따른 지역을 가져온다.
    @Override
    public ArrayList<DivisionVO> getDivision_Region(int theme_NUM) {
        if (theme_NUM == 0) {
            return null;
        }

        return travelInfoDAO.selectDivisionList(theme_NUM);
    }

}
