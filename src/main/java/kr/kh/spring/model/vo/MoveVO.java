package kr.kh.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MoveVO {
    private int move_daydetail_NUM;
    private int move_time;
    private String move_transportation;
    private int move_cost;
    
}
