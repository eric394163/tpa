
package kr.kh.spring.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.kh.spring.model.vo.ThemeVO;
import kr.kh.spring.service.TravelInfoService;

@Controller
public class PlanningController {  

    @Autowired
    TravelInfoService travelInfo_s;

    // =================경로 관리 시작=================

    @RequestMapping(value = "/planning/selecttheme", method = RequestMethod.GET)
    public String themeList(Model model) {

        ArrayList<ThemeVO> themeList = travelInfo_s.getThemeList();
        model.addAttribute("themeList", themeList);

        return "/planning/selecttheme";
    }

    @GetMapping("/selectregion")
    public String selectregion(@RequestParam("theme_NUM") int themeNum, Model model) {
        // You can now use themeNum in your method
        model.addAttribute("selectedThemeNum", themeNum);

        

        return "planning/selectregion"; 
    }

    // =================경로 관리 끝=================

}
