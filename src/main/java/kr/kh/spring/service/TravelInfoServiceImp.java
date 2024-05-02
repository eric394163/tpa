package kr.kh.spring.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.kh.spring.dao.TravelInfoDAO;
import kr.kh.spring.model.vo.DivisionVO;
import kr.kh.spring.model.vo.PlaceVO;
import kr.kh.spring.model.vo.RegionVO;
import kr.kh.spring.model.vo.ThemeVO;
import kr.kh.spring.pagination.PlaceCriteria;

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

    @Override
    public ArrayList<PlaceVO> getPlaceList(PlaceCriteria cri) {

        System.out.println("cri.getTheme_NUM() : " + cri.getTheme_NUM());
        System.out.println("cri.getRegion_NUM() : " + cri.getRegion_NUM());
        System.out.println("cri.getPlacetypelist_NUM() : " + cri.getPlacetypelist_NUM());

        if (cri.getTheme_NUM() == 0 && cri.getRegion_NUM() == 0 && cri.getPlacetypelist_NUM() == 0) {
           System.out.println("막힘");
            return null;
        }

        if (cri.getPlacetypelist_NUM() == -1) {
            System.out.println("-1");

            return travelInfoDAO.selectPlaceByRegionAndTheme(cri);
        }
        if (cri.getPlacetypelist_NUM() == 1) {
            System.out.println("1");
 
            return travelInfoDAO.selectPlaceByRegionAndThemeMost(cri);
        } else {
            System.out.println("else");

            return travelInfoDAO.selectPlaceByRegionAndThemeAndType(cri);
        }
    }

    @Override
    public ArrayList<PlaceVO> getSearchPlaceList(PlaceCriteria cri) {
        if(cri.getSearch() == null) {
            return null;
        }
        return travelInfoDAO.selectPlaceBySearch(cri);
    }

    // @Override
    // public int getPlaceTotalCount(PlaceCriteria cri) {
    // // TODO Auto-generated method stub
    // throw new UnsupportedOperationException("Unimplemented method
    // 'getPlaceTotalCount'");
    // }

}
