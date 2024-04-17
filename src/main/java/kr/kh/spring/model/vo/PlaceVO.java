package kr.kh.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PlaceVO {
    private int place_NUM;
    private int place_region_NUM;
    private String place_id;
    private String place_name;
    private double place_rating;
    private String place_content;
    private String place_address;
    
}
