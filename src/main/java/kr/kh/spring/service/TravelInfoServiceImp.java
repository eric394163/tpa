package kr.kh.spring.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.spring.dao.TravelInfoDAO;
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


    @Override
    public ArrayList<RegionVO> getRegionList(int theme_NUM) {
        if(theme_NUM==0){
            return null;
        }

        return travelInfoDAO.selectRegionList(theme_NUM);
    }

}
