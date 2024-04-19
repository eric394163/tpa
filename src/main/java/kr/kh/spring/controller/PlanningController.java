
package kr.kh.spring.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.kh.spring.model.vo.RegionVO;
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

    @GetMapping("/planning/selectregion")
    public String selectregion(@RequestParam("theme_NUM") int theme_NUM, Model model) {

        Map<Integer, List<RegionVO>> mapDivision_Region = travelInfo_s.getDivision_Region();
        ArrayList<List<RegionVO>> regionLists = new ArrayList<>();
        for (int i = 0; i < mapDivision_Region.size(); i++) {
            regionLists.add(i, mapDivision_Region.get(i + 1));
        }
        model.addAttribute("regionLists", regionLists);

        return "/planning/selectregion";
    }

    // =================경로 관리 끝=================

}
