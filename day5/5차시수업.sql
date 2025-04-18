CREATE TABLE  t_emp(
eid VARCHAR2(13) NOT NULL PRIMARY KEY,
ename VARCHAR2(20),
salary NUMBER(5),         
deptno NUMBER(5),
comm NUMBER(5)
);
COMMIT;
 
INSERT INTO  t_emp VALUES ('e001' , '신동엽' , 280,10,100) ;
INSERT INTO  t_emp VALUES ('e002' , '유재석' , 250,20,50) ;
INSERT INTO  t_emp VALUES ('e003' , '전현무' , 190,30,0) ;
INSERT INTO  t_emp VALUES ('e004' , '양세영' , 300,20,0) ;
INSERT INTO  t_emp VALUES ('e005' , '양세찬' , 290,40,100) ;
CREATE TABLE  t_dept(
deptno NUMBER(5) NOT NULL PRIMARY KEY ,
dname VARCHAR2(20)   
);
COMMIT;

INSERT INTO  t_dept VALUES (10 , '영업팀') ;
INSERT INTO  t_dept VALUES (20 , '기획팀') ;
INSERT INTO  t_dept VALUES (30 , '관리팀') ;
INSERT INTO  t_dept VALUES (40 , '마케팅팀') ;
INSERT INTO  t_dept VALUES (50 , '재무팀') ;


SELECT * FROM T_EMP;
SELECT * FROM T_DEPT;


--뷰만들기
CREATE VIEW V_EMP
AS
SELECT ENAME, DEPTNO
FROM T_EMP;


SELECT * FROM V_EMP;

--
SELECT *
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;

--
SELECT O.ODATE, G.PNAME, O.SALE_CNT, G.PRICE
FROM TBL_TEST_ORDER O
JOIN TBL_TEST_GOODS G
ON O.PCODE = G.PCODE;


--뷰만들기
CREATE VIEW V_ORDER_TEST
AS
    SELECT O.ODATE, G.PNAME, O.SALE_CNT, G.PRICE
    FROM TBL_TEST_ORDER O
    JOIN TBL_TEST_GOODS G
    ON O.PCODE = G.PCODE;
    
SELECT * FROM V_ORDER_TEST;


SELECT * FROM V_ORDER_TEST
WHERE SALE_CNT >=4;


--뷰의 종류
--단순뷰 (한 개의 테이블로 뷰 만들기)
--복합뷰 (조인테이블로 뷰 만들기)
--인라인 뷰 ---> 서브쿼리의 종류


--TBL_TEST_ORDER
--TBL_TEST_GOODS
--TBL_TEST_CUSTOMER

SELECT * FROM TBL_TEST_CUSTOMER;

--
DELETE FROM TBL_TEST_CUSTOMER WHERE ID='H007';
COMMIT;

--인라인뷰 경험하기
--고객별 판매수량 합계 구하기

--1) 고객별 판매수량의 합계 구하기
--2) 고객테이블과 조인하여 결과 만들기

SELECT * FROM TBL_TEST_ORDER;


SELECT ID, SALE_CNT FROM TBL_TEST_ORDER;

SELECT ID, SUM(SALE_CNT)
FROM TBL_TEST_ORDER
GROUP BY ID;


SELECT *
FROM (
    SELECT ID, SUM(SALE_CNT)
    FROM TBL_TEST_ORDER
    GROUP BY ID
    ) A
JOIN TBL_TEST_CUSTOMER C
ON A.ID = C.ID;


SELECT C.NAME, A.CNT
FROM (
    SELECT ID, SUM(SALE_CNT) CNT
    FROM TBL_TEST_ORDER
    GROUP BY ID
    ) A
JOIN TBL_TEST_CUSTOMER C
ON A.ID = C.ID;


--서브쿼리 : 하나의 쿼리 안에 또 다른 쿼리가 있는 것을 서브쿼리라고 한다


--뷰만들기
--CREATE VIEW 뷰이름
--AS
--SELECT절

--(테이블 한개 - 단순뷰)
--(테이블 여러개 - 복합뷰)

--FROM절 뒤에 서브쿼리 (  )가 인라인 뷰라고 한다.




--서브쿼리
SELECT * FROM T_EMP; 

--신동엽 사원보다 급여가 더 많은 사원이름, 급여, 상여금 조회 하시오
SELECT SALARY FROM T_EMP WHERE ENAME='신동엽';

SELECT * FROM T_EMP
WHERE SALARY > 280;

--성공한 서브쿼리로 변경 
SELECT * FROM T_EMP
WHERE SALARY > (SELECT SALARY FROM T_EMP WHERE ENAME='신동엽');
--단일행 서브쿼리 연산 =, <>, >=, <=, >, <

SELECT SALARY FROM T_EMP WHERE ENAME='신동엽';
--신동엽의 급여는 280 한 개가 나옴 => 단일행 서브쿼리이다


--p429
--연습문제1. STUDENT 테이블과 DEPARTMENT 테이블을 사용하여
--'Anthony Hopkins'학생과 1전공이 동일한 학생들의 이름과 1전공 이름 출력
SELECT * FROM STUDENT;
SELECT * FROM DEPARTMENT;

--Anthony Hopkins의 1전공 출력
SELECT DEPTNO1 FROM STUDENT WHERE NAME='Anthony Hopkins';

--1전공이 같은 학생 이름 출력
SELECT NAME FROM STUDENT
WHERE DEPTNO1 = (SELECT DEPTNO1 FROM STUDENT WHERE NAME='Anthony Hopkins');

--조인
SELECT * 
FROM STUDENT S
JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO;

SELECT S.DEPTNO1, S.NAME, D.DNAME
FROM STUDENT S
JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO;

--1전공이 같은 학생 전공이름 출력
SELECT D.DNAME
FROM STUDENT S
JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO
WHERE DEPTNO1 = (SELECT DEPTNO1 FROM STUDENT WHERE NAME='Anthony Hopkins');

--1전공이 같은 학생이름과 전공이름 출력
SELECT S.NAME, D.DNAME
FROM STUDENT S
JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO
WHERE DEPTNO1 = (SELECT DEPTNO1 FROM STUDENT WHERE NAME='Anthony Hopkins');




--위에 문제 같이 풀어보기
SELECT * FROM STUDENT;
SELECT * FROM DEPARTMENT;

--103
SELECT * FROM STUDENT
WHERE NAME = 'Anthony Hopkins';

SELECT * FROM STUDENT
WHERE DEPTNO1 = '103';
--둘이 값이 같음 왜냐면 Anthony Hopkins 얘 1전공이 103이니까; 아무튼 밑에거는 서브쿼리 이용
SELECT * FROM STUDENT
WHERE DEPTNO1 = 
(SELECT DEPTNO1 FROM STUDENT 
WHERE NAME = 'Anthony Hopkins');

--학생과 학과테이블을 조인해서
SELECT *
FROM STUDENT S
JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO;

--
SELECT *
FROM STUDENT S
JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO
WHERE S.DEPTNO1 = '103';
--서브쿼리이용할게염
SELECT *
FROM STUDENT S
JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO
WHERE S.DEPTNO1 =
(SELECT DEPTNO1 FROM STUDENT 
WHERE NAME = 'Anthony Hopkins');

--최종 ~~~
SELECT S.NAME, D.DNAME
FROM STUDENT S
JOIN DEPARTMENT D
ON S.DEPTNO1 = D.DEPTNO
WHERE S.DEPTNO1 =
(SELECT DEPTNO1 FROM STUDENT 
WHERE NAME = 'Anthony Hopkins');



--다중행 서브쿼리
SELECT * FROM T_EMP;
SELECT * FROM T_DEPT;

--다중행 서브쿼리란 서브쿼리의 결과가 여러행을 반환하는 서브쿼리를 말한다
SELECT SALARY FROM T_EMP WHERE SALARY >= 280; --급여 280이상 서브쿼리

SELECT * FROM T_EMP
WHERE SALARY IN (SELECT SALARY FROM T_EMP WHERE SALARY >= 280);

SELECT * FROM T_EMP
WHERE SALARY IN (280,300,290);


--  >ANY  <ANY
--  >ALL  <ALL

-- ANY : 서브쿼리의 여러 행의 값에 하나라도 만족하면 됨
-- ALL : 서브쿼리의 여러 행의 값에 모두 만족하면 됨 
SELECT * FROM T_EMP
WHERE SALARY >= ANY (SELECT SALARY FROM T_EMP WHERE SALARY >= 280);
--다중쿼리의 내용중에 하나라도 만족하면 출력됨 ANY 

SELECT * FROM T_EMP
WHERE SALARY >= ALL (SELECT SALARY FROM T_EMP WHERE SALARY >= 280);
--이거는 다중쿼리 내용이 다 만족해야됨 뭔소리야시발 280 290은 왜 안돼?
-- 아니 최솟값 최댓값이라는데?음.;.....


--EXISTS ()
--서브쿼리가 존재하면 메인쿼리를 실행한다. 서브쿼리의 결과가 존재하지 않으면 실행되지 않는다
SELECT * FROM T_EMP
WHERE EXISTS (SELECT DEPTNO FROM T_DEPT WHERE DEPTNO=70); --서브쿼리 결과 존재하지않음


--다중컬럼 (같은 조건만 비교가능하다)
SELECT GRADE, MAX(WEIGHT)
FROM STUDENT
GROUP BY GRADE;
--학년별 최고몸무게?;;;;

SELECT GRADE, NAME, WEIGHT
FROM STUDENT
WHERE (GRADE, WEIGHT)
IN (SELECT GRADE, MAX(WEIGHT)
FROM STUDENT
GROUP BY GRADE);


--FROM절 뒤에 오는 서브쿼리 (인라인뷰 서브쿼리라고 함), 하나의 뷰가 만들어짐

--쿼리가 복잡해질 때 뷰를 사용하거나
--FROM절 뒤에 서브쿼리로 사용할 수 있다 (인라인 뷰라고 함)


--고객별 판매수량의 합계
--권지언 9
--이동우 6
--오윤석 2
--윤현기 1
--임형택 3

--1) 고객별 판매수량의 합계 구하기
--2) 1)의 쿼리결과와 고객테이블을 조인해서 전체 쿼리를 완성

SELECT ID, SALE_CNT FROM TBL_TEST_ORDER;

SELECT * 
FROM (
SELECT ID, SUM(SALE_CNT)CNT
FROM TBL_TEST_ORDER
GROUP BY ID) A
JOIN TBL_TEST_CUSTOMER C
ON A.ID = C.ID;

--
SELECT A.ID, C.NAME, A.CNT
FROM (
    SELECT ID, SUM(SALE_CNT) CNT
    FROM TBL_TEST_ORDER
    GROUP BY ID) A
JOIN TBL_TEST_CUSTOMER C
ON A.ID = C.ID;


SELECT * FROM TBL_TEST_CUSTOMER;



--p420 
--연습문제1. PROFESSOR 테이블과 DEPARTMENT 테이블을 조인하여 교수번호와 교수이름, 소속학과이름을 조회하는 VIEW 생성
--VIEW이름은 V_PROF_DEPT2
SELECT * FROM PROFESSOR; 
SELECT * FROM DEPARTMENT;
--교수번호PROFNO 교수이름NAME 소속학과DNAME
--DEPTNO로 조인
SELECT P.PROFNO, P.NAME, D.DNAME
FROM PROFESSOR P
JOIN DEPARTMENT D
ON P.DEPTNO = D.DEPTNO;

--뷰만들기
--CREATE VIEW 뷰이름
--AS
--SELECT절
CREATE VIEW V_PROF_DEPT2
AS
    SELECT P.PROFNO, P.NAME, D.DNAME
    FROM PROFESSOR P
    JOIN DEPARTMENT D
    ON P.DEPTNO = D.DEPTNO;

SELECT * FROM V_PROF_DEPT2;



--연습문제2. 인라인 뷰를 사용하여 STUDENT 테이블과 DEPARTMENT 테이블에서 학과별로 최대 키와 최대 몸무게, 학과이름 출력
SELECT * FROM STUDENT;
SELECT * FROM DEPARTMENT;

--학과별 최대 키, 최대 몸무게
SELECT DEPTNO1, MAX(HEIGHT), MAX(WEIGHT)
FROM STUDENT
GROUP BY DEPTNO1;
--그니까 저거랑 DEPARTMENT를 조인해서 학과이름을 출력하라고? ㅇㅋ

SELECT D.DNAME, A.MAX_HEIGHT, A.MAX_WEIGHT
FROM (SELECT DEPTNO1, MAX(HEIGHT) MAX_HEIGHT, MAX(WEIGHT) MAX_WEIGHT
FROM STUDENT 
GROUP BY DEPTNO1) A
JOIN DEPARTMENT D
ON A.DEPTNO1 = D.DEPTNO;



--연습문제3. STUDENT 테이블과 DEPARTMENT 테이블을 사용하여 학과 이름, 학과별 최대키, 
--학과별로 가장 키가 큰 학생들의 이름과 키를 인라인 뷰를 사용해서 출력
SELECT * FROM STUDENT;
SELECT * FROM DEPARTMENT;

--학과별 최대키
SELECT DEPTNO1, MAX(HEIGHT)
FROM STUDENT
GROUP BY DEPTNO1;
--학과이름 출력해서
SELECT D.DNAME, A.MAX_HEIGHT
FROM (SELECT DEPTNO1, MAX(HEIGHT) MAX_HEIGHT
        FROM STUDENT
        GROUP BY DEPTNO1) A
JOIN DEPARTMENT D
ON A.DEPTNO1 = D.DEPTNO;

--학과별 키가 가장 큰 학생
SELECT D.DNAME, A.MAX_HEIGHT
FROM (SELECT DEPTNO1, MAX(HEIGHT) MAX_HEIGHT
        FROM STUDENT
        GROUP BY DEPTNO1) A
JOIN STUDENT S
ON A.DEPTNO1 = S.DEPTNO1 AND A.MAX_HEIGHT = S.HEIGHT
JOIN DEPARTMENT D
ON A.DEPTNO1 = D.DEPTNO;

--학생이름이랑 키도 출력
SELECT D.DNAME, A.MAX_HEIGHT, S.NAME, S.HEIGHT
FROM (SELECT DEPTNO1, MAX(HEIGHT) MAX_HEIGHT
        FROM STUDENT
        GROUP BY DEPTNO1) A
JOIN STUDENT S
ON A.DEPTNO1 = S.DEPTNO1 AND A.MAX_HEIGHT = S.HEIGHT
JOIN DEPARTMENT D
ON A.DEPTNO1 = D.DEPTNO;



--P420 
--연습문제1. 수민
 CREATE VIEW V_PROF_DEPT2
 AS SELECT p.profno, p.name, d.dname
 FROM PROFESSOR P
 JOIN DEPARTMENT D
 ON P.DEPTNO = D.DEPTNO;
 
--연습문제2. 시우
SELECT * FROM student;
SELECT * FROM department;
-- 서브쿼리
SELECT s.DEPTNO1,max(s.HEIGHT),max(s.WEIGHT) 
FROM student s
GROUP BY s.DEPTNO1;
-- 메인
SELECT * FROM department;
-- 합체
SELECT d.DNAME,maxValues.MAX_HEIGHT,maxValues.MAX_WEIGHT
FROM (SELECT s.DEPTNO1,max(s.HEIGHT) max_height,max(s.WEIGHT) max_weight 
		FROM student s
		GROUP BY s.DEPTNO1) maxValues
JOIN DEPARTMENT d 
ON d.DEPTNO = maxValues.DEPTNO1;

--연습문제3. 지언
select tb.dname, tb.newmax as max_height , st.name , st.height
from ( select d.dname, max(s.height) as newmax, s.deptno1
       from student s
       join department d
       on s.deptno1 = d.deptno
       group by deptno1 , dname 
     )tb, student st
where st.height = tb.newmax and st.deptno1 = tb.deptno1;


--3번
--학과별 키가 가장 큰 학생의 이름 조회하기, 학과명과 함께 조회하기
--1) 학과별 가장 큰 키 조회하기
--2) 1번 쿼리의 내용을 학생테이블로 조인하여 학과별 가장 큰 키의 학생정보 조회하기(같은학과, 키가 같아야 한다)
--3) 학과테이블 조인하여 학과명 가져오기
SELECT * FROM STUDENT;

SELECT DEPTNO1, HEIGHT
FROM STUDENT;

--학과별 가장 큰 키 조회하기
SELECT DEPTNO1, MAX(HEIGHT)
FROM STUDENT
GROUP BY DEPTNO1;

SELECT *
FROM(SELECT DEPTNO1, MAX(HEIGHT) MAX_HEIGHT
    FROM STUDENT
    GROUP BY DEPTNO1) A
JOIN STUDENT S
ON A.DEPTNO1 = S.DEPTNO1 AND A.MAX_HEIGHT = S.HEIGHT;

--
SELECT A.DEPTNO1, D.DNAME, S.NAME, A.MAX_HEIGHT, S.HEIGHT
FROM(SELECT DEPTNO1, MAX(HEIGHT) MAX_HEIGHT
    FROM STUDENT
    GROUP BY DEPTNO1) A
JOIN STUDENT S
ON A.DEPTNO1 = S.DEPTNO1 AND A.MAX_HEIGHT = S.HEIGHT
JOIN DEPARTMENT D
ON A.DEPTNO1 = D.DEPTNO;



--서브쿼리
--연관쿼리 : 서브쿼리에서 메인쿼리의 내용을 사용하는 쿼리
--비연관쿼리 : 서브쿼리에서 메인쿼리의 내용을 사용안함

SELECT * FROM T_EMP;

--비연관쿼리
--평균 SALARY보다 많이 받는 사람 조회하기
SELECT *
FROM T_EMP
WHERE SALARY >= (SELECT AVG(SALARY) FROM T_EMP); --급여를 T_EMP테이블 급여의 평균보다 많이 받는 사람


--연관서브쿼리
--자신이 속한 부서의 평균
SELECT * FROM T_EMP;

SELECT *
FROM T_EMP E
WHERE SALARY = (SELECT MAX(SALARY) FROM T_EMP TE WHERE E.DEPTNO = TE.DEPTNO);



--SQL -DDL, DML, DCL
--DML (데이터 조작언어)
--SELECT (READ)
--INSERT (CREATE)
--UPDATE (UPDATE)
--DELETE (DELETE)
SELECT * FROM ACORNTBL2;

--등록하기 인인밸
INSERT INTO ACORNTBL2(ID, PW, NAME, POINT) VALUES('hong','1234','홍길동',100);  
INSERT INTO ACORNTBL2 VALUES('hong2','5678','홍길순',200);
COMMIT;


--변경하기 업셋웨 (UPDATE로 변경하기) - WHERE절 없으면 모든 행이 변경됨, WHERE절 확인하기
UPDATE ACORNTBL2
SET POINT = POINT +1000
WHERE ID = 'umin';
COMMIT; --커밋을 해야 영구적으로 바뀜 아 졸려 

--비밀번호
--che 아이디를 가진 회원의 비밀번호 변경하기
UPDATE ACORNTBL2
SET pw = '0409'
WHERE ID = 'che';
COMMIT;

SELECT * FROM ACORNTBL2;

--여러개 변경
UPDATE ACORNTBL2
SET PW='0448', POINT=5000
WHERE ID='boseong00';
COMMIT;


--데이터 삭제하기 델프웨, WHERE절 주의, WHERE절이 없으면 테이블의 모든 행을 삭제하게 됨.. 주의!!
DELETE 
FROM ACORNTBL2
WHERE ID='hong';
COMMIT;




--p420
--연습문제 4. STUDENT 테이블에서 학생의 키가 동일 학년의 평균 키보다 큰 학생들의 학년과 이름, 키, 해당 학년의 평균 키 출력
--인라인 뷰를 사용 학년 컬럼으로 오름차순 정렬 출력
SELECT * FROM STUDENT;

--학년별 평균키
SELECT GRADE, AVG(HEIGHT)
FROM STUDENT
GROUP BY GRADE;

--각 학년 평균보다 큰 학생
SELECT GRADE, NAME, HEIGHT
FROM STUDENT
WHERE HEIGHT > (SELECT AVG(HEIGHT) FROM STUDENT)
ORDER BY GRADE;

--평균키까지 출력
SELECT S.GRADE, S.NAME, S.HEIGHT, A.AVG_HEIGHT
FROM STUDENT S
JOIN (SELECT GRADE, AVG(HEIGHT) AVG_HEIGHT FROM STUDENT GROUP BY GRADE) A
ON S.GRADE = A.GRADE
WHERE HEIGHT > (SELECT AVG(HEIGHT) AVG_HEIGHT FROM STUDENT)
ORDER BY GRADE;

--최종??
SELECT S.GRADE, S.NAME, S.HEIGHT, A.AVG_HEIGHT
FROM STUDENT S 
JOIN (SELECT GRADE, AVG(HEIGHT) AVG_HEIGHT FROM STUDENT GROUP BY GRADE) A
ON S.GRADE = A.GRADE
WHERE HEIGHT > A.AVG_HEIGHT
ORDER BY GRADE;


SELECT S.GRADE, S.NAME, S.HEIGHT, A.AVG_HEIGHT
FROM STUDENT S
JOIN (SELECT GRADE, AVG(HEIGHT) AS AVG_HEIGHT FROM STUDENT GROUP BY GRADE) A
ON S.GRADE = A.GRADE
WHERE S.HEIGHT > A.AVG_HEIGHT
ORDER BY S.GRADE;


--p430 (단일행 서브쿼리)
--연습문제3. STUDENT 테이블에서 1전공이 201인 학과의 평균몸무게보다 몸무게가 많은 학생들의 이름과 몸무게 출력
SELECT * FROM STUDENT;
--학과별 평균몸무게 근데 이거는 필요가 없는건데??
SELECT DEPTNO1, AVG(WEIGHT) FROM STUDENT
GROUP BY DEPTNO1;

--1전공이 201인 학과의 평균몸무게 이게맞나 모르겠다 이거맞나?
SELECT DEPTNO1, AVG(WEIGHT) 
FROM STUDENT
WHERE DEPTNO1 = '201'
GROUP BY DEPTNO1;
--맞음 201의 평균몸무게 서브쿼리
SELECT AVG(WEIGHT)
FROM STUDENT
WHERE DEPTNO1 = '201';

--평균몸무게보다 몸무게 많은 학생들
SELECT NAME, WEIGHT
FROM STUDENT
WHERE WEIGHT >
    (SELECT AVG(WEIGHT) 
    FROM STUDENT
    WHERE DEPTNO1 = '201');

--p434
--연습문제1. EMP2 테이블에서 'Section head' 직급의 최소 연봉자보다 연봉이 높은 사람의 이름과 직급, 연봉 출력
--(단, 연봉 출력 형식은 천 단위 구분 기호와 999,999 $표시를 하세요)
SELECT * FROM EMP2;

--'Section head' 직급의 최소 연봉
SELECT MIN(PAY)
FROM EMP2
WHERE POSITION='Section head';

--최소연봉보다 높은 사람의 이름, 직급, 연봉 출력
SELECT NAME, POSITION, TO_CHAR(PAY, '$999,999,999')
FROM EMP2
WHERE PAY > (SELECT MIN(PAY) FROM EMP2 WHERE POSITION='Section head')
ORDER BY PAY DESC;

--근데 단위는 어케해 뭐야 이거
SELECT TO_CHAR(PAY, '$999,999,999')
FROM EMP2; 
-- 999,999로 해서 그런거였음 값보다 작게해서..... 하 999,999,999로 해결


