
package kr.kh.spring.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.kh.spring.model.vo.DivisionVO;
import kr.kh.spring.model.vo.PlaceVO;
import kr.kh.spring.model.vo.ThemeVO;
import kr.kh.spring.pagination.Criteria;
import kr.kh.spring.pagination.PageMaker;
import kr.kh.spring.pagination.PlaceCriteria;
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
    // 테마가 있으면 테마에 따른 지역을 불러옴
    @GetMapping("/planning/selectregion")
    public String selectregion(int theme_NUM, Model model) {

        ArrayList<DivisionVO> divisionList = travelInfo_s.getDivision_Region(theme_NUM);

        model.addAttribute("divisionList", divisionList);
        model.addAttribute("theme_NUM", theme_NUM);

        return "/planning/selectregion";
    }

    @GetMapping("/planning/selectdate")
    public String selectdate(int region_NUM, int theme_NUM, Model model) {

        model.addAttribute("region_NUM", region_NUM);
        model.addAttribute("theme_NUM", theme_NUM);

        return "/planning/selectdate";
    }

    @PostMapping("/planning/selectstart")
    public String selectstartPost(Model model, @RequestParam("startDate") String schedule_startDate,
            @RequestParam("endDate") String schedule_endDate,
            int region_NUM, int theme_NUM) {
        model.addAttribute("startDate", schedule_startDate);
        model.addAttribute("endDate", schedule_endDate);
        model.addAttribute("regionNum", region_NUM);
        model.addAttribute("themeNum", theme_NUM);

        return "/planning/selectstart";
    }

    // - 함수명 : selectplacePost
    // - 매개변수 : Model model, String schedule_startDate, String schedule_endDate, int
    // region_NUM, int theme_NUM, String startPlaceId, String startPlaceLat, String
    // startPlaceLng
    // - 기능 : 장소를 선택하는 페이지로 이동하고 장소 리스트를 가져온다.
    @PostMapping("/planning/selectplace")
    public String selectplacePost(Model model,
            @RequestParam("startDate") String schedule_startDate,
            @RequestParam("endDate") String schedule_endDate,
            @RequestParam("regionNum") int region_NUM,
            @RequestParam("themeNum") int theme_NUM,
            @RequestParam("startPlaceId") String startPlaceId,
            @RequestParam("startPlaceLat") String startPlaceLat,
            @RequestParam("startPlaceLng") String startPlaceLng) {

        model.addAttribute("startDate", schedule_startDate);
        model.addAttribute("endDate", schedule_endDate);
        model.addAttribute("regionNum", region_NUM);
        model.addAttribute("themeNum", theme_NUM);
        model.addAttribute("startPlaceId", startPlaceId);
        model.addAttribute("startPlaceLat", startPlaceLat);
        model.addAttribute("startPlaceLng", startPlaceLng);

        PlaceCriteria cri = new PlaceCriteria();

        int noParam = -1;
        int page = 1;
        int perPageNum = 1;

        cri.setPage(page);
        cri.setPerPageNum(perPageNum);
        cri.setRegion_NUM(region_NUM);
        cri.setTheme_NUM(theme_NUM);
        cri.setPlacetypelist_NUM(noParam);

        ArrayList<PlaceVO> placeList = travelInfo_s.getPlaceList(cri);
        int totalCount = travelInfo_s.getPlaceTotalCount(cri);
        System.out.println("totalCount: " + totalCount);
        PageMaker pm = new PageMaker(1, cri, totalCount);
        model.addAttribute("placeList", placeList);
        model.addAttribute("pm", pm);

        return "/planning/selectplace";
    }

    @GetMapping("/planning/placebytype")
    public String placebytype(Model model, @RequestParam("type") String type, @RequestParam("currentPage") int currentPage,
            @RequestParam("regionNum") int region_NUM, @RequestParam("themeNum") int theme_NUM) {
        System.out.println("type: " + type);

        PlaceCriteria cri = new PlaceCriteria();
        int perPageNum = 1;

        cri.setPage(currentPage);
        cri.setPerPageNum(perPageNum);
        cri.setRegion_NUM(region_NUM);
        cri.setTheme_NUM(theme_NUM);

        if (type.equals("추천")) {
            cri.setPlacetypelist_NUM(1);
        } else if (type.equals("식당")) {
            cri.setPlacetypelist_NUM(2);
        } else if (type.equals("카페")) {
            cri.setPlacetypelist_NUM(3);
        } else if (type.equals("관광지")) {
            cri.setPlacetypelist_NUM(4);
        } else if (type.equals("숙소")) {
            cri.setPlacetypelist_NUM(5);
        } else {
            cri.setPlacetypelist_NUM(-1);
        }

        ArrayList<PlaceVO> placeList = travelInfo_s.getPlaceList(cri);
        int totalCount = travelInfo_s.getPlaceTotalCount(cri);
        PageMaker pm = new PageMaker(1, cri, totalCount);
        model.addAttribute("placeList", placeList);
        model.addAttribute("pm", pm);
        return "/planning/place/placebytype";
    }

    @GetMapping("/planning/searchplace")
    public String placeSearch(Model model,
            @RequestParam("regionNum") int region_NUM,
            @RequestParam("themeNum") int theme_NUM,
            @RequestParam("search") String search) {

        PlaceCriteria cri = new PlaceCriteria();

        int page = 1;
        int perPageNum = 1;

        cri.setSearch(search);
        cri.setPage(page);
        cri.setPerPageNum(perPageNum);
        cri.setRegion_NUM(region_NUM);
        cri.setTheme_NUM(theme_NUM);

        ArrayList<PlaceVO> searchPlaceList = travelInfo_s.getSearchPlaceList(cri);
        int totalCount = travelInfo_s.getSearchPlaceListCount(cri);
        PageMaker pm = new PageMaker(3, cri, totalCount);
        model.addAttribute("placeList", searchPlaceList);
        model.addAttribute("pm", pm);
        return "/planning/place/placebytype";
    }
}
