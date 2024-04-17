package kr.kh.spring.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class UserVO {
    private int user_NUM;
    private String user_id;
    private String user_email;
    private String user_nickname;
    private String user_pw;
    private Date user_stateDate;
    private String user_state;
    private int user_follow;
    private String user_role;
    private String user_content;
    private String user_imgUrl;

}
