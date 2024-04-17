package kr.kh.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class FollowVO {
    private int follow_NUM;
    private int follow_folowing;
    private int follow_folowed;
    
}
