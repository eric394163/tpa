package kr.kh.spring.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class DayVO {
    private int day_NUM;
    private int day_schedule_NUM;
    private Date day_startTime;
    private int day_n;
}
