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


desc tbl_join_200;

desc tbl_join_200;


select * from tbl_join_200;




select  gender  , decode( gender , 'M','남자', 'F','여자') 
from tbl_join_200;


select join_id, 
       join_nm,
       to_char( to_date( birth), 'yyyy"년"mm"월"dd"일' ), 
       decode( gender , 'M','남자', 'F','여자')  , 
       decode( specialty  , 'D' ,'댄스' ,'V','보컬','R','랩'), charm
from tbl_join_200;


select birth  ,   to_date( birth) 
from tbl_join_200;

select birth  ,   to_char( to_date( birth), 'yyyy"년"mm"월"dd"일' )
from tbl_join_200;


select specialty  , decode( specialty  , 'D' ,'댄스' ,'V','보컬','R','랩')
from  tbl_join_200;

--

select join_id, 
       join_nm,
       to_char( to_date( birth), 'yyyy"년"mm"월"dd"일' )  as  birth, 
       decode( gender , 'M','남자', 'F','여자')  as gender , 
       decode( specialty  , 'D' ,'댄스' ,'V','보컬','R','랩'), charm
from tbl_join_200;



--2번
select  * 
from tbl_score_200 s
join tbl_join_200  j
on  s.artistid  = j.join_id
join tbl_mentor_200  m
on s.mentorid  = m.mentor_id;

--

select  s.score_no, s.artistid  , j.join_nm   ,  j.birth , s.score, m.mentor_nm
from tbl_score_200 s
join tbl_join_200  j
on  s.artistid  = j.join_id
join tbl_mentor_200  m
on s.mentorid  = m.mentor_id;




select  s.score_no, s.artistid  , j.join_nm   ,  
                substr(j.birth, 1,4)||'년'  ||  substr( j.birth,5,2)  || '월'   ||   substr( j.birth, 7,2)  || '일' ,
                s.score,  case when score >=90 then  'A'
                     when  score>=80 then  'B'
                     when  score >=70 then 'C'
                     else 'D'
                end as result , m.mentor_nm
from tbl_score_200 s
join tbl_join_200  j
on  s.artistid  = j.join_id
join tbl_mentor_200  m
on s.mentorid  = m.mentor_id;



select birth   , substr(birth, 1,4)||'년'  ||  substr( birth,5,2)  || '월'   ||   substr( birth, 7,2)  || '일' 
from  tbl_join_200;

select score  , case when score >=90 then  'A'
                     when  score>=80 then  'B'
                     when  score >=70 then 'C'
                     else 'D'
                end as result
from  tbl_score_200;
 


select * from tbl_join_200;
select * from tbl_mentor_200;
select  *  from tbl_score_200;





--그룹함수
--순위구하기

SELECT * FROM ACORNTBL2;

--RANK() 순위구하기
select name, point, rank() over(order by point)
FROM ACORNTBL2;

select name, point, rank() over(order by point DESC )
FROM ACORNTBL2;


--DENSE_RANK
SELECT NAME, POINT, DENSE_RANK() OVER(ORDER BY POINT DESC)
FROM acorntbl2;


--ROW_NUMBER(): 같은등수일때 ROWID를 기준으로 순위를 매김
--ROW ID는 행을 식별하는 고유번호
SELECT NAME, POINT, DENSE_RANK() OVER(ORDER BY POINT DESC)
FROM acorntbl2;


--누적합
--전체합

--누적합
SELECT NAME, POINT, SUM(POINT) OVER()
FROM ACORNTBL2;


--첫 행에서 현재 행까지의 누적합 구하기
SELECT NAME, POINT, SUM(POINT) OVER(ORDER BY POINT)
FROM ACORNTBL2;


SELECT NAME, POINT, SUM(POINT) OVER(ORDER BY NAME)
FROM ACORNTBL2;

--

SELECT NAME, POINT, SUM(POINT) 
                    OVER( ORDER BY POINT
                    Range  BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
                    )-- 등수가 같으면 같은범위로 인식함
FROM ACORNTBL2;


SELECT NAME, POINT, SUM(POINT) 
                    OVER( ORDER BY POINT
                    ROWS  BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
                    )
FROM ACORNTBL2;


--누적합의 범위 지정
--RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW (기본임)
--ROWS BETWEEN UBBOUNDED PRECEDING AND CURRENT ROW

--UNBOUNDED PRECEDING : 첫 행에서부터
--CURRENT ROW         : 현재행까지

SELECT NAME, POINT, SUM(POINT) 
OVER(ORDER BY POINT ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM ACORNTBL2;


--
SELECT * FROM MEMBER_TBL_11;

--포인트 누적합 구하기
--고객등급별 누적합 구하기

SELECT M_NAME, M_GRADE, M_POINT
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL;

--전체합
SELECT M_NAME, M_GRADE, M_POINT, SUM(M_POINT) OVER()
FROM MEMBER_TBL_11;
WHERE M_POINT IS NOT NULL;

--포인트 누적합
SELECT M_NAME, M_GRADE, M_POINT, SUM(M_POINT) OVER()
FROM MEMBER_TBL_11;
WHERE M_POINT IS NOT NULL;



SELECT M_NAME, M_GRADE, M_POINT, SUM(M_POINT) 
OVER(ORDER BY M_POINT RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL;


--SELECT M_NAME, M_GRADE, M_POINT, SUM(M_POINT) 
--OVER(PARTITION BY M_GRADE ORDER BY M_POINT)
--FROM MEMBER_TBL_11;

--고객등급별 포인트 누적합
SELECT M_NAME, M_GRADE, M_POINT, SUM(M_POINT) 
OVER(PARTITION BY M_GRADE ORDER BY M_POINT)
FROM MEMBER_TBL_11;


--그룹바이 
--ROLL UP(부분합 구하기) - 선행조건이 GROUP BY 한 후에 집계를 내고 싶을 때 사용

--
SELECT * FROM MEMBER_TBL_11;

SELECT SUM(M_POINT) FROM MEMBER_TBL_11;

SELECT M_GRADE, M_POINT FROM MEMBER_TBL_11;

SELECT M_GRADE, SUM(M_POINT) FROM MEMBER_TBL_11
GROUP BY M_GRADE;


--집계
--ROLLUP()
SELECT M_GRADE, SUM(M_POINT) FROM MEMBER_TBL_11
GROUP BY ROLLUP(M_GRADE);

SELECT * FROM TBL_TEST_ORDER;
SELECT * FROM TBL_TEST_GOODS;


SELECT *
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;


-- 상품별 판매수량합계 구하기
SELECT G.PNAME, G.PRICE, O.SALE_CNT
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;


SELECT G.PNAME, SUM(G.PRICE * O.SALE_CNT)
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE
GROUP BY ROLLUP(G.PNAME);


SELECT NVL(G.PNAME,'TOTAL'), SUM(G.PRICE * O.SALE_CNT)
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE
GROUP BY ROLLUP(G.PNAME);


-- 고객별 제품별 판매금액
SELECT * FROM
TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
JOIN ON TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;


SELECT C.NAME, G.PNAME, SUM(G.PRICE * O.SALE_CNT) 
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE
GROUP BY C.NAME, G.PNAME
ORDER BY 1;


--고객별 합계
--고객별 제품별 합계
--전체합계


-- LAG() 함수 이전행의 값을 가져올 때 사용(판매실적)
SELECT * FROM ACORNTBL2;


SELECT NAME, POINT, LAG(POINT, 1, 0) OVER(ORDER BY POINT)
FROM ACORNTBL2;


--LEAD()함수 다음행의 값을 가져올 때 사용 
SELECT NAME, POINT, LEAD(POINT, 1, 0) OVER(ORDER BY POINT)
FROM ACORNTBL2;


--PIVOT 테이블
SELECT *
FROM EMP;


--DECODE로 부서별 직급별 사원 수 구하기
SELECT DECODE(JOB, 'CLERK', 1), DECODE(JOB, 'SALESMAN', 1)
FROM EMP;

SELECT COUNT(JOB), COUNT(DECODE(JOB,'CLERK',1)), COUNT(DECODE(JOB, 'SALESMAN', 1))
FROM EMP;

SELECT DEPTNO, DECODE(JOB, 'CLERK', 1), DECODE(JOB, 'SALESMAN', 1)
FROM EMP;

SELECT DEPTNO, COUNT(DECODE(JOB, 'CLERK', 1)), COUNT(DECODE(JOB, 'SALESMAN', 1))
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;

SELECT DEPTNO, COUNT(DECODE(JOB, 'CLERK', 1)) AS "CLERK", COUNT(DECODE(JOB, 'SALESMAN', 1)) AS "SALESMAN"
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;

--
SELECT * FROM (SELECT DEPTNO, JOB, EMPNO FROM EMP) 
PIVOT(
    COUNT(EMPNO) FOR JOB IN('CLERK' AS "CLERK", 'MANAGER' AS "MANAGER",
    'SALESMAN' AS "SALESMAN", 'ANALYST' AS "ANALYST", 'PRESIDENT' AS "PRESIDENT")
);


-- 비율구하기
-- SELECT * FROM MEMBER_TBL_11;

SELECT * FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL;

--
SELECT M_NAME, M_POINT , SUM(M_POINT) OVER()
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL;

--
SELECT M_NAME, M_POINT, SUM(M_POINT) OVER(), ROUND(M_POINT / SUM(M_POINT) OVER() * 100,2)
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL;


--RATIO_TO_REPORT 사용하여 비율구하기
SELECT M_NAME, M_POINT, ROUND(RATIO_TO_REPORT(M_POINT) OVER()*100,2 ) --소수점둘째자리까지반올림
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL;


--참가자 등수 조회
SELECT *
FROM TBL_SCORE_200 S
JOIN TBL_JOIN_200 J
ON S.ARTISTID = J.JOIN_ID;

SELECT S.ARTISTID, J.JOIN_NM, SCORE, SCORE
FROM TBL_SCORE_200 S
JOIN TBL_JOIN_200 J
ON S.ARTISTID = J.JOIN_ID;

SELECT S.ARTISTID, J.JOIN_NM, SUM(SCORE), AVG(SCORE)
FROM TBL_SCORE_200 S
JOIN TBL_JOIN_200 J
ON S.ARTISTID = J.JOIN_ID
GROUP BY S.ARTISTID, J.JOIN_NM;

SELECT S.ARTISTID, J.JOIN_NM, SUM(SCORE), AVG(SCORE), RANK() OVER(ORDER BY AVG(SCORE) DESC)
FROM TBL_SCORE_200 S
JOIN TBL_JOIN_200 J
ON S.ARTISTID = J.JOIN_ID
GROUP BY S.ARTISTID, J.JOIN_NM;

SELECT  S.ARTISTID,
        J.JOIN_NM,
        SUM(SCORE) AS 총점, 
        ROUND(AVG(SCORE),2) AS 평균, 
        RANK() OVER(ORDER BY AVG(SCORE) DESC) AS 등수
FROM TBL_SCORE_200 S
JOIN TBL_JOIN_200 J
ON S.ARTISTID = J.JOIN_ID
GROUP BY S.ARTISTID, J.JOIN_NM;



--RANK() 순위 구하기
--SUM() OVER() 전체합 구하기, 누적합 구하기
--LAG() OVER() 이전 행 가져오기
--LEAD() OVER() 다음 행 가져오기
--ROLLUP() 집계 (선행조건 GROUP BY)
--RATIO_TO_REPORT() OVER() 비율구하기
--PIVOT 




