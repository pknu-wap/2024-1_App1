package com.pknuErrand.appteam.dto.errand.getDto;

import com.pknuErrand.appteam.Enum.ErrandStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class ErrandPaginationRequestVo {
    private Long pk;
    private String cursor;
    private int limit;
    private ErrandStatus errandStatus;
}
