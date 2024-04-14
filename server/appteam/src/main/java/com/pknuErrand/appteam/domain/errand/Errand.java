package com.pknuErrand.appteam.domain.errand;


import com.pknuErrand.appteam.domain.errand.saveDto.ErrandSaveRequestDto;
import com.pknuErrand.appteam.domain.member.Member;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import java.sql.Timestamp;

@Getter
@NoArgsConstructor
@Entity(name = "errand")
public class Errand {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column
    private long errandNo;


    @ManyToOne // 이 어노테이션 걸면 자동으로 getter를 해주나.. ?
    @JoinColumn
    private Member orderNo; // 심부름 시킨사람의 pk

    @Column
    private Timestamp createdDate; // 등록한 date

    @Column
    private String title;

    @Column
    private String destination;

    @Column
    private double latitude;

    @Column
    private double longitude;

    @Column
    private Timestamp due; // 몇시까지?

    @Column
    private String detail;

    @Column
    private int reward;

    @Column
    private Boolean isCash;

    @Column
    @Enumerated(EnumType.STRING)
    private Status status;

    @ManyToOne
    @JoinColumn
    private Member erranderNo; // 심부름꾼

    public void changeErrandStatusAndSetErrander(Status status, Member errander) {
        this.status = status;
        erranderNo = errander;
    }

    public void updateErrand(Timestamp createdDate, String title, String destination,
                             double latitude, double longitude, Timestamp due, String detail,
                             int reward, Boolean isCash, Status status) {
        this.createdDate = createdDate;
        this.title = title;
        this.destination = destination;
        this.latitude = latitude;
        this.longitude = longitude;
        this.due = due;
        this.detail = detail;
        this.reward = reward;
        this.isCash = isCash;
        this.status = status;
    }
    public Errand(Member orderNo, Timestamp createdDate, String title, String destination,
                  double latitude, double longitude, Timestamp due, String detail,
                  int reward, Boolean isCash, Status status, Member erranderNo) {
        this.orderNo = orderNo;
        this.createdDate = createdDate;
        this.title = title;
        this.destination = destination;
        this.latitude = latitude;
        this.longitude = longitude;
        this.due = due;
        this.detail = detail;
        this.reward = reward;
        this.isCash = isCash;
        this.status = status;
        this.erranderNo = erranderNo;
    }
}
