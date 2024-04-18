package kr.kh.spring.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import kr.kh.spring.model.vo.RegionVO;
import kr.kh.spring.model.vo.ThemeVO;

@Service
public interface TravelInfoService {

    ArrayList<ThemeVO> getThemeList();

    ArrayList<RegionVO> getRegionList(int theme_NUM);
    
}
