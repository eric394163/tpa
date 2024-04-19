package kr.kh.spring.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.kh.spring.model.vo.RegionVO;
import kr.kh.spring.model.vo.ThemeVO;

@Service
public interface TravelInfoService {

    ArrayList<ThemeVO> getThemeList();


    Map<Integer, List<RegionVO>> getDivision_Region();
    
}
