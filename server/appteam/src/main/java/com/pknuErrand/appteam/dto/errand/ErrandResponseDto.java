package com.pknuErrand.appteam.dto.errand;

import com.pknuErrand.appteam.domain.errand.Errand;
import com.pknuErrand.appteam.Enum.Status;
import com.pknuErrand.appteam.domain.member.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ErrandResponseDto { // from Entity

    private Member orderNo; // 심부름 시킨사람

    private String createdDate; // 등록한 date

    private String title; // 심부름 제목

    private String destination; // 도착지

    private double latitude; // 위도

    private double longitude; // 경도

    private String due; // 몇시까지?

    private String detail; // 상세 내용

    private int reward; // 보수금액

    private Boolean isCash; // 현금 계좌이체 선택

    private Status status; // 상태

    private Member erranderNo; // 심부름꾼

    public ErrandResponseDto(Errand errand) {
        this.orderNo = errand.getOrderNo();
        this.createdDate = errand.getCreatedDate();
        this.title = errand.getTitle();
        this.destination = errand.getDestination();
        this.latitude = errand.getLatitude();
        this.longitude = errand.getLongitude();
        this.due = errand.getDue();
        this.detail = errand.getDetail();
        this.reward = errand.getReward();
        this.isCash = errand.getIsCash();
        this.status = errand.getStatus();
        this.erranderNo = errand.getErranderNo();
    }

}
