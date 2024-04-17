package kr.kh.spring.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class LikeVO {
    private int like_user_NUM;
    private int like_schedule_NUM;
}
