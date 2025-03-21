
create table tbl_test_customer(
    id varchar2(20) not null primary key ,
    name varchar2(20) ,
    address varchar2(20),
    tel varchar2(20)
);

create table tbl_test_goods(
  pcode varchar2(20) not null primary key,
  pname varchar(20) ,
  price number(4)
);

create table tbl_test_order(
  ocode varchar2(20) not null primary key,
  odate date,
  id varchar2(20),
 pcode varchar2(20),
 sale_cnt number(6)
);



insert into tbl_test_customer values( 'H001' ,'권지언', '라스베가스', '010-3030-2222');
insert into tbl_test_customer values( 'H002' ,'이동우', 'L.A', '010-2424-2222');
insert into tbl_test_customer values( 'H003' ,'오윤석', '워싱턴D.C', '010-1010-2121');
insert into tbl_test_customer values( 'H004' ,'윤현기', '뉴욕', '010-3333-2222');
insert into tbl_test_customer values( 'H005' ,'임형택', '텍사스', '010-9090-2222');
insert into tbl_test_customer values( 'H006' ,'김민환', '서울', '010-7878-1234');

insert into tbl_test_customer values( 'H007' ,'황예지', '서울 관악구', '010-2002-0106');
COMMIT;
 


insert into tbl_test_goods values('P001' ,'쫀드기', 1000);
insert into tbl_test_goods values('P002' ,'눈깔사탕', 100);
insert into tbl_test_goods values('P003' ,'아폴로', 200);
insert into tbl_test_goods values('P004' ,'뻥튀기', 2000);



insert into tbl_test_order values('J001' , '20210110' , 'H001', 'P001', 2);
insert into tbl_test_order values('J002' , '20210110' , 'H002', 'P002', 5);
insert into tbl_test_order values('J003' , '20210110' , 'H003', 'P003', 2);
insert into tbl_test_order values('J004' , '20210110' , 'H004', 'P004', 1);
insert into tbl_test_order values('J005' , '20210110' , 'H005', 'P002', 3);
insert into tbl_test_order values('J006' , '20210110' , 'H001', 'P002', 3);
insert into tbl_test_order values('J007' , '20210110' , 'H002', 'P001', 1);
insert into tbl_test_order values('J008' , '20210110' , 'H001', 'P002', 4);
 


 

// sql  조인 표준 

SELECT  name, address, tel, odate, pname, sale_cnt, price, sale_cnt * price
FROM   tbl_test_order o
JOIN     tbl_test_customer c
ON       o.id = c.id
JOIN     tbl_test_goods g
ON       o.pcode = g.pcode ;




SELECT   *
FROM   tbl_test_order o
JOIN     tbl_test_customer c
ON       o.id = c.id;
 


SELECT   *
FROM   tbl_test_order o
JOIN     tbl_test_customer c
ON       o.id = c.id
JOIN     tbl_test_goods g
ON       o.pcode = g.pcode ;



SELECT * FROM   tbl_test_customer ;
SELECT * FROM    tbl_test_goods ;
SELECT * FROM   tbl_test_order;


--원하는 정보가 한 개의 테이블에 존재하지 않으면
--조인해야함

-- 표준조인
-- 주문테이블, 상품테이블
SELECT *
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;


SELECT *
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;


SELECT *
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;


SELECT C.NAME, G.PNAME, O.SALE_CNT, G.PRICE
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;


--주문현황 조회

SELECT * FROM   tbl_test_customer ;
SELECT * FROM   tbl_test_goods ;
SELECT * FROM   tbl_test_order;


-- EQUI조인
-- INNER조인
SELECT *
FROM TBL_TEST_ORDER O 
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;

SELECT C.NAME, O.SALE_CNT
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID; 

--고객별 판매수량의 합계

SELECT C.NAME, SUM(O.SALE_CNT)
FROM TBL_TEST_ORDER O 
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
GROUP BY C.NAME;

SELECT C.NAME, SUM(O.SALE_CNT)
FROM TBL_TEST_ORDER O 
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
GROUP BY C.NAME
ORDER BY 2 DESC;

SELECT C.NAME, SUM(O.SALE_CNT) || '개' CNT
FROM TBL_TEST_ORDER O 
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
GROUP BY C.NAME
ORDER BY 2 DESC;


--EQUI조인 ON절에서 같은거 찾는 조인 조건
--INNER 

--내부조인 INNER조인 (두 테이블에 모두 존재하는 경우만 결과에 나옴)
SELECT C.NAME, SUM(O.SALE_CNT)
FROM TBL_TEST_ORDER O 
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
GROUP BY C.NAME;

-- INNER 조인 (기본)
-- OUTER 조인 


--(INNER) JOIN : => 양쪽에 모두 있는 것만 조회됨
SELECT *
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;

--
SELECT O.ODATE, C.NAME, O.DALE_CNT
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;

SELECT O.SALE_CNT
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;

--전체합계
SELECT SUM(O.SALE_CNT)
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;

SELECT C.NAME, SUM(O.SALE_CNT)
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
GROUP BY C.NAME;


--주문현황
--주문,고객,상품

SELECT *
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;


SELECT O.ODATE, C.NAME, G.PNAME, G.PRICE, O.SALE_CNT, G.PRICE * O.SALE_CNT
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;

--

SELECT O.ODATE,
        C.NAME, 
        G.PNAME,
        TO_CHAR(G.PRICE,'999,999'),
        O.SALE_CNT, 
        TO_CHAR(G.PRICE * O.SALE_CNT, '999,999') AS "AMOUNT"
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;




SELECT * FROM   tbl_test_customer ;
SELECT * FROM    tbl_test_goods ;
SELECT * FROM   tbl_test_order;


SELECT 
        C.NAME,
        TO_CHAR(G.PRICE * O.SALE_CNT, '999,999') AS "AMOUNT"
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;


SELECT 
        C.NAME,
        SUM(G.PRICE * O.SALE_CNT) AS AMOUNT
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE
GROUP BY C.NAME;



SELECT * FROM   tbl_test_customer ;
SELECT * FROM    tbl_test_goods ;
SELECT * FROM   tbl_test_order;


--231페이지
--1. EMPNO ENAME DAME 책처럼 출력
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT *
FROM EMP
JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;
--조인확인

SELECT EMPNO, ENAME, DNAME
FROM EMP 
JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

SELECT E.EMPNO, E.ENAME, D.DNAME
FROM EMP E
JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

--2.STUDENT와 PROFESSOR을 조인하여 학생의 이름과 지도교수 이름을 출력
SELECT * FROM STUDENT;
SELECT * FROM PROFESSOR;

SELECT *
FROM STUDENT S
JOIN PROFESSOR P
ON S.PROFNO = P.PROFNO;
--조인확인

SELECT S.NAME, P.NAME
FROM STUDENT S
JOIN PROFESSOR P
ON S.PROFNO = P.PROFNO;

SELECT S.NAME STU_NAME, P.NAME PROF_NAME
FROM STUDENT S
JOIN PROFESSOR P
ON S.PROFNO = P.PROFNO;

--
SELECT *
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;

SELECT C.NAME, O.SALE_CNT
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;


--OUTER JOIN
--조인시 일치하지 않은 것도 함께 조회함
SELECT C.NAME, O.SALE_CNT
FROM TBL_TEST_ORDER O
LEFT OUTER JOIN TBL_TEST_CUSTOMER C
ON O.ID = C.ID;

