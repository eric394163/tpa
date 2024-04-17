package kr.kh.spring.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class FollowVO {
    private int follow_NUM;
    private int follow_folowing;
    private int follow_folowed;
    
}
