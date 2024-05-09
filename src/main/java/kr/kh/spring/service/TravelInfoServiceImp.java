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

    // - 함수명 : getPlaceList
    // - 매개변수 : PlaceCriteria cri
    // - 기능 : 장소 리스트를 가져온다.
    // - 상세기능 : 타입이 -1 ( 없음 ) 이면 지역과 테마에 따른 장소 가져오고
    // 타입이 1 (추천) 이면 많이 일정에 등록된 지역과 테마에 따른 장소 가져옴
    // 타임이 2 이상이면 타입에 따른 지역과 테마에 따르는 장소 가져옴
    // 수정 : 타입 -1은 사용 안 함 
    @Override
    public ArrayList<PlaceVO> getPlaceList(PlaceCriteria cri) {

        if (cri.getTheme_NUM() == 0 && cri.getRegion_NUM() == 0 && cri.getPlacetypelist_NUM() == 0) {
            return null;
        }

        // if (cri.getPlacetypelist_NUM() == -1) { 
        //     return travelInfoDAO.selectPlaceByRegionAndTheme(cri);
        // }
        if (cri.getPlacetypelist_NUM() == 1) {

            return travelInfoDAO.selectPlaceByRegionAndThemeMost(cri);
        } else {

            return travelInfoDAO.selectPlaceByRegionAndThemeAndType(cri);
        }
    }

    // - 함수명 : getPlaceTotalCount
    // - 매개변수 : PlaceCriteria cri
    // - 기능 : 장소 리스트의 총 개수를 가져온다.
    // - 상세기능 : 타입이 -1 ( 없음 ) 이면 지역과 테마에 따른 장소의 총 개수를 가져오고
    // 타입이 1 (추천) 이면 많이 일정에 등록된 지역과 테마에 따른 장소의 총 개수를 가져옴
    // 타임이 2 이상이면 타입에 따른 지역과 테마에 따르는 장소의 총 개수를 가져옴
    // 수정 : 타입 -1은 사용 안 함
    @Override
    public int getPlaceTotalCount(PlaceCriteria cri) {
        if (cri.getTheme_NUM() == 0 && cri.getRegion_NUM() == 0 && cri.getPlacetypelist_NUM() == 0) {
            return 0;
        }
        // if (cri.getPlacetypelist_NUM() == -1) {
        //     return travelInfoDAO.selectPlaceTotalCount(cri);
        // }
        if (cri.getPlacetypelist_NUM() == 1) {
            return travelInfoDAO.selectPlaceTotalCountMost(cri);
        } else {
            return travelInfoDAO.selectPlaceTotalCountType(cri);
        }

    }

    // - 함수명 : getSearchPlaceList
    // - 매개변수 : PlaceCriteria cri
    // - 기능 : 검색어에 따른 장소 리스트를 가져온다.
    @Override
    public ArrayList<PlaceVO> getSearchPlaceList(PlaceCriteria cri) {
        if (cri.getSearch() == null) {
            return null;
        }
        return travelInfoDAO.selectPlaceBySearch(cri);
    }

    @Override
    public int getSearchPlaceListCount(PlaceCriteria cri) {
        if (cri.getSearch() == null) {
            return 0;
        }
        return travelInfoDAO.selectPlaceTotalCountSearch(cri);
    }

    @Override
    public double getRegionLat(int region_NUM) {
        if(region_NUM == 0) {
            return 0;
        }
        return travelInfoDAO.selectRegionLat(region_NUM);
    }

    @Override
    public double getRegionLng(int region_NUM) {
        if(region_NUM == 0) {
            return 0;
        }
        return travelInfoDAO.selectRegionLng(region_NUM);
    }

    @Override
    public boolean placeExists(String placeId) {
        return travelInfoDAO.selectCountByPlaceId(placeId) > 0;
    }


    @Override
    public void addPlace(int regionNum, double placeRating, String placeId, String placeName, double lat, double lng, String placeAddress) {
        travelInfoDAO.insertPlace(regionNum, placeRating, placeId, placeName, lat, lng, placeAddress);
    }


    
}
