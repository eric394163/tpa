package kr.kh.spring.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class DaydetailVO {
    private int daydetail_NUM;
    private int daydetail_place_NUM;
    private int daydetail_day_NUM;
    private int daydetail_place_time;
    private int daydetail_order;
    
}
