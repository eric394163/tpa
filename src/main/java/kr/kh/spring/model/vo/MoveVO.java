package kr.kh.spring.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MoveVO {
    private int move_daydetail_NUM;
    private int move_time;
    private String move_transportation;
    private int move_cost;
    
}
