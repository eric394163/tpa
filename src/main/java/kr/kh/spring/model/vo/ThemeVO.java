package kr.kh.spring.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ThemeVO {
    private int theme_NUM;
    private String theme_name;
    private String theme_imgUrl;

}
