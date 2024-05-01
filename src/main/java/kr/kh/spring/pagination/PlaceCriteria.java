package kr.kh.spring.pagination;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class PlaceCriteria extends Criteria {

    private int theme_NUM;
    private int region_NUM;
    private int placetypelist_NUM;

    public PlaceCriteria(int page, int perPageNum, int theme_NUM, int region_NUM, int placetypelist_NUM) {
        super(page, perPageNum);
        this.theme_NUM = theme_NUM;
        this.region_NUM = region_NUM;
        this.placetypelist_NUM = placetypelist_NUM;

    }

}
