package kr.kh.spring.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LikeVO {
    private int like_user_NUM;
    private int like_schedule_NUM;
}
