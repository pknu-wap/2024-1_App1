package com.pknuErrand.appteam.dto.errand;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class InProgressErrandListResponseDto {
    private long errandNo;
    private String title;
    private String due;
    private Boolean isUserOrder;
}
