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

    // int getPlaceTotalCount(PlaceCriteria cri);

    
}
