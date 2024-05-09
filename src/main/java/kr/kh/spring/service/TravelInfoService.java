package kr.kh.spring.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import kr.kh.spring.model.vo.DivisionVO;
import kr.kh.spring.model.vo.PlaceVO;
import kr.kh.spring.model.vo.ThemeVO;
import kr.kh.spring.pagination.PlaceCriteria;

@Service
public interface TravelInfoService {

    ArrayList<ThemeVO> getThemeList();

    ArrayList<DivisionVO> getDivision_Region(int theme_NUM);

    ArrayList<PlaceVO> getPlaceList(PlaceCriteria cri);

    ArrayList<PlaceVO> getSearchPlaceList(PlaceCriteria cri);

    int getPlaceTotalCount(PlaceCriteria cri);

    int getSearchPlaceListCount(PlaceCriteria cri);

    double getRegionLat(int region_NUM);

    double getRegionLng(int region_NUM);

    boolean placeExists(String placeId);

    void addPlace(int regionNum, double placeRating, String placeId, String placeName, double lat, double lng, String placeAddress);



    
}
