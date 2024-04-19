package kr.kh.spring.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    public Map<Integer, List<RegionVO>> getDivision_Region() {
        Map<Integer, List<RegionVO>> mapDivision_Region = new HashMap<Integer, List<RegionVO>>();

        int division_NUM;

        int totalDivisionCount = travelInfoDAO.selectTotalDivisionCount();

        for (division_NUM = 1; division_NUM <= totalDivisionCount; division_NUM++) {
            List<RegionVO> regionList = travelInfoDAO.selectRegionList(division_NUM);
            mapDivision_Region.put(division_NUM, regionList);
        }

        return mapDivision_Region;
    }

}
