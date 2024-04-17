package kr.kh.spring.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ThemeVO {
    private int theme_NUM;
    private String theme_name;
    private String theme_imgUrl;

}
