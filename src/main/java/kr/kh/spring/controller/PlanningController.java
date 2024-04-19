
package kr.kh.spring.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.kh.spring.model.vo.DivisionVO;
import kr.kh.spring.model.vo.ThemeVO;

import kr.kh.spring.service.TravelInfoService;

@Controller
public class PlanningController {

    @Autowired
    TravelInfoService travelInfo_s;


    @RequestMapping(value = "/planning/selecttheme", method = RequestMethod.GET)
    public String themeList(Model model) {

        ArrayList<ThemeVO> themeList = travelInfo_s.getThemeList();
        model.addAttribute("themeList", themeList);

        return "/planning/selecttheme";
    }

    // - 함수명 : selectregion
    // - 매개변수 : int theme_NUM, Model model
    // - 기능 : 테마에 따른 지역을 선택하는 페이지로 이동한다.
    // - 상세기능 : 테마가 없으면 필터링 없이 불러옴
    //             테마가 있으면 테마에 따른 지역을 불러옴
    @GetMapping("/planning/selectregion")
    public String selectregion(@RequestParam("theme_NUM") int theme_NUM, Model model) {

        ArrayList<DivisionVO> divisionList = travelInfo_s.getDivision_Region(theme_NUM);

        model.addAttribute("divisionList", divisionList);

        return "/planning/selectregion";
    }

    @GetMapping("/planning/selectdate")
    public String selectStart(@RequestParam("region_NUM") int region_NUM, Model model) {

        return "/planning/selectdate";
    }


    
}
