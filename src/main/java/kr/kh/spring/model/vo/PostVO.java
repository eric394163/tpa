package kr.kh.spring.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PostVO {
    private int post_schedule_NUM;
    private String post_title;
    private Date post_date;
    private String post_content;
    private int post_view;
    private int post_like;
    
}
