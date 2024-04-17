package kr.kh.spring.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ScheduleVO {
    private int schedule_NUM;
    private int schedule_region_NUM;
    private int schedule_user_NUM;
    private int schedule_theme_NUM;
    private String schedule_title;
    private Date schedule_startDate;
    private Date schedule_endDate;
    private int schedule_totalMoveCost;
    private String schedule_content;
    
}
