package kr.kh.spring.model.vo;

import java.util.ArrayList;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DivisionVO {
    private int division_NUM;
    private String division_name;
    private ArrayList<RegionVO> regionList;
}
