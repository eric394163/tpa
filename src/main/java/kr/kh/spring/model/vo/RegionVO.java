package kr.kh.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RegionVO {
    private int region_NUM;
    private String region_do;
    private String region_name;
    private String region_imgUrl;
}
