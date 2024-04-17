package kr.kh.spring.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SingUpDTO {
    private String user_id;
    private String user_email;
    private String user_nickname;
    private String user_pw;
    private String user_imgUrl;
    
}
