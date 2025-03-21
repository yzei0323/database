create table tbl_join_200(
  join_id varchar2(4)  not null primary key ,
  join_nm varchar2(20)  ,
  birth  char(8),
  gender char(1),
  specialty varchar2(1),
  charm varchar2(30)
);

insert into tbl_join_200 values( 'A001' , '케이쥬',  '20050102' , 'M', 'D', '깜찍댄스');
insert into tbl_join_200 values( 'A002' , '고키',  '20090102' , 'M', 'D', '동전마술');
insert into tbl_join_200 values( 'A003' , '나윤서',  '20070102' , 'M', 'D', '창작댄스');
insert into tbl_join_200 values( 'A004' , '장현수',  '20030103' , 'M', 'R', '보컬');
insert into tbl_join_200 values( 'A005' , '윤민',  '20020205' , 'M', 'V', '자작곡');


create table tbl_mentor_200(
    mentor_id varchar2(4) not null primary key ,
    mentor_nm varchar2(20)
);

insert into tbl_mentor_200 values( 'J001', '박진영');
insert into tbl_mentor_200 values( 'J002', '박재상');
insert into tbl_mentor_200 values( 'J003', '보아');



create table tbl_score_200(
  score_no  number(6) not null ,
  artistid varchar2(4) not null,
  mentorid varchar2(4) not null,
  score number(3),
  primary key( score_no, artistid, mentorid)
);

insert into tbl_score_200 values( 110001, 'A001', 'J001' , 80);
insert into tbl_score_200 values( 110002, 'A001', 'J002' , 90);
insert into tbl_score_200 values( 110003, 'A001', 'J003' , 70);
insert into tbl_score_200 values( 110004, 'A002', 'J001' , 60);
insert into tbl_score_200 values( 110005, 'A002', 'J002' , 50);
insert into tbl_score_200 values( 110006, 'A002', 'J003' , 70);
insert into tbl_score_200 values( 110007, 'A003', 'J001' , 80);
insert into tbl_score_200 values( 110008, 'A003', 'J002' , 60);
insert into tbl_score_200 values( 110009, 'A003', 'J003' , 70);
insert into tbl_score_200 values( 110010, 'A004', 'J001' , 80);
insert into tbl_score_200 values( 110011, 'A004', 'J002' , 78);
insert into tbl_score_200 values( 110012, 'A004', 'J003' , 89);
insert into tbl_score_200 values( 110013, 'A005', 'J001' , 62);
insert into tbl_score_200 values( 110014, 'A005', 'J002' , 91);
insert into tbl_score_200 values( 110015, 'A005', 'J003' , 67);


SELECT * FROM TBL_JOIN_200;
SELECT * FROM TBL_MENTOR_200;
SELECT * FROM TBL_SCORE_200;


--참가자조회
SELECT JOIN_ID 참가자ID, JOIN_NM 참가자이름, BIRTH 생년월일, GENDER 성별, SPECIALTY 실력무대, CHARM 매력무대
FROM TBL_JOIN_200;

SELECT  JOIN_ID 참가자ID,
        JOIN_NM 참가자이름,
        TO_CHAR(TO_DATE(BIRTH),'YYYY"년"MM"월"DD"일"') 생년월일,
        DECODE(GENDER,'M','남성','F','여성') 성별,
        DECODE(SPECIALTY,'D','댄스','R','랩','V','보컬') 실력무대, 
        CHARM 매력무대
FROM TBL_JOIN_200;


--참가자 점수조회
SELECT  S.SCORE_NO 계좌번호, J.JOIN_ID 참가자ID, J.JOIN_NM 참가자이름,
        J.BIRTH 생년월일, S.SCORE 점수, S.SCORE 등급, S.MENTORID 멘토이름
FROM TBL_SCORE_200 S
JOIN TBL_JOIN_200 J
ON S.ARTISTID = J.JOIN_ID;


SELECT  S.SCORE_NO 계좌번호,
        J.JOIN_ID 참가자ID,
        J.JOIN_NM 참가자이름,
        TO_CHAR(TO_DATE(J.BIRTH),'YYYY"년"MM"월"DD"일"') 생년월일,
        S.SCORE 점수,
        CASE WHEN S.SCORE >= 90 THEN 'A'
             WHEN S.SCORE >= 80 THEN 'B'
             WHEN S.SCORE >= 70 THEN 'C'
             ELSE 'D'
             END 등급,
        DECODE(S.MENTORID,'J001','박진영','J002','박재상','J003','보아') 멘토이름
FROM TBL_SCORE_200 S
JOIN TBL_JOIN_200 J
ON S.ARTISTID = J.JOIN_ID;


SELECT  S.SCORE_NO 계좌번호,
        J.JOIN_ID 참가자ID,
        J.JOIN_NM 참가자이름,
        TO_CHAR(TO_DATE(J.BIRTH),'YYYY"년"MM"월"DD"일"') 생년월일,
        S.SCORE 점수,
        CASE WHEN S.SCORE >= 90 THEN 'A'
             WHEN S.SCORE >= 80 THEN 'B'
             WHEN S.SCORE >= 70 THEN 'C'
             ELSE 'D'
             END 등급,
        M.MENTOR_NM
FROM TBL_SCORE_200 S
JOIN TBL_MENTOR_200 M
ON S.MENTORID = M.MENTOR_ID
JOIN TBL_JOIN_200 J
ON S.ARTISTID = J.JOIN_ID;



--참가자 등수 조회
SELECT JOIN_ID 참가자ID, JOIN_NM 참가자이름, SCORE 총합점수, SCORE 평균점수
FROM TBL_JOIN_200 J
JOIN TBL_SCORE_200 S
ON J.JOIN_ID = S.ARTISTID;

SELECT JOIN_ID 참가자ID, JOIN_NM 참가자이름, SUM(SCORE) 총합점수, SCORE 평균점수
FROM TBL_JOIN_200 J
JOIN TBL_SCORE_200 S
ON J.JOIN_ID = S.ARTISTID;


SELECT * FROM TBL_JOIN_200;
SELECT * FROM TBL_MENTOR_200;
SELECT * FROM TBL_SCORE_200;
