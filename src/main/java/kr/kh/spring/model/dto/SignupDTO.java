package kr.kh.spring.model.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SignupDTO {
    private String id;
    private String email;
    private String nickname;
    private String pw;
    private String imgUrl;
}
