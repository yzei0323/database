
--P243 연습문제 3번
SELECT * FROM EMP2; --사원정보
SELECT * FROM P_GRADE; --직급정보


--나이구하기
SELECT BIRTHDAY FROM EMP2;

-- 날짜 - 날짜 = 일 수
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('1985-12-10')) / 12) FROM DUAL;
SELECT TRUNC((SYSDATE - TO_DATE('1985-12-10')) / 365) FROM DUAL;

--
SELECT  BIRTHDAY, 
        TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('1985-12-10')) / 12) AGE
FROM EMP2;
        
--
SELECT  NAME,
        TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('1985-12-10')) / 12) AGE
FROM EMP2;

--JOIN
SELECT  NAME,
        TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE('1985-12-10')) / 12) AGE
FROM EMP2 E
JOIN P_GRADE G
ON TRUNC(MONTHS_BETWEEN(SYSDATE, BIRTHDAY) / 12) BETWEEN G.S_AGE AND G.E_AGE;

--
SELECT *
FROM(SELECT  NAME, 
             TRUNC(MONTHS_BETWEEN(SYSDATE, BIRTHDAY) / 12) AGE
     FROM EMP2) A
JOIN P_GRADE G
ON A.AGE BETWEEN G.S_AGE AND G.E_AGE;
     
--최종
SELECT A.NAME, A.AGE, A.CURRENTPOSITION, G.POSITION
FROM(SELECT  NAME, POSITION CURRENTPOSITION,  
             TRUNC(MONTHS_BETWEEN(SYSDATE, BIRTHDAY) / 12) AGE
     FROM EMP2) A
JOIN P_GRADE G
ON A.AGE BETWEEN G.S_AGE AND G.E_AGE;
--찐최종
SELECT A.NAME, A.AGE, NVL(A.CURRENTPOSITION,' '), G.POSITION
FROM(SELECT  NAME, POSITION CURRENTPOSITION,  
             TRUNC(MONTHS_BETWEEN(SYSDATE, BIRTHDAY) / 12) AGE
     FROM EMP2) A
JOIN P_GRADE G
ON A.AGE BETWEEN G.S_AGE AND G.E_AGE;



--4번
--CUSTOMER 테이블 고객정보-적립포인트
--적립된 포인트보다 낮은거 중에서 노트북을 받을 수 있는 사람 조회하시오
SELECT * FROM CUSTOMER;
SELECT * FROM GIFT;


--놀았습빈다





--테이블생성하기
CREATE TABLE MEMBER_ACORN(
    ID VARCHAR(50) PRIMARY KEY,
    PWD VARCHAR2(50),
    NAME VARCHAR2(50),
    GENDER CHAR(6),
    AGE NUMBER(3),
    BIRTHDAY DATE,
    PHONE CHAR(13)
);


--테이블에서 주키 설정 필수
--CHAR : 고정길이형 문자이기 때문에 빈공간은 빈 공백으로 채워짐, 비교할 때 주의!!

SELECT * FROM MEMBER_ACORN;


--테이블 수정하기
--한글은 3BYTE!!, 자리 수 고려 '홍길동' 들어가려면 최소 9BYTE!
CREATE TABLE MEMBER_TEST(
    ID VARCHAR2(7) PRIMARY KEY,
    NAME VARCHAR2(10)
);

INSERT INTO MEMBER_TEST(ID, NAME) VALUES ('TEST', '홍길동');
COMMIT; 

SELECT * FROM MEMBER_TEST;

--테이블 수정
--ALTER TABLE 테이블명

--컬럼 추가하기
ALTER TABLE MEMBER_TEST ADD(ADDR VARCHAR2(50));

--이름 변경하기  컬럼이름변경 ID->USER_ID
ALTER TABLE MEMBER_TEST RENAME COLUMN ID TO USER_ID;

--수정하기 VARCHAR값? 10->30
ALTER TABLE MEMBER_TEST MODIFY NAME VARCHAR2(30);
INSERT INTO MEMBER_TEST(USER_ID, NAME) VALUES ('TEST2', '홍길동홍길동홍길동');
COMMIT;

SELECT * FROM MEMBER_TEST;

--컬럼삭제하기  ADDR 컬럼삭제
ALTER TABLE MEMBER_TEST DROP COLUMN ADDR;

--테이블 삭제하기
DROP TABLE MEMBER_TEST;
SELECT * FROM MEMBER_TEST;

--테이블의 스키마 그대로 존재함  
TRUNCATE TABLE MEMBER_ACORN;
SELECT * FROM MEMBER_ACORN;

-----완전삭제는 DROP 내용삭제는 TRUNCATE 인서트했던거 싹.사라짐


--테이블 생성시 속성에 기본값 설정하기
CREATE TABLE AA(
    ID VARCHAR2(10),
    WRITEDAY DATE
);

INSERT INTO AA(ID) VALUES('TEST01');
SELECT * FROM AA;


CREATE TABLE BB(
    ID VARCHAR2(10),
    WRITEDAY DATE DEFAULT SYSDATE
);

INSERT INTO BB (ID) VALUES('TEST01');
SELECT * FROM BB;


--테이블 복사하기 (내용과 함께)
SELECT * FROM STUDENT;
--STUDENT 테이블 복사하기
CREATE TABLE STUDENT_NEW
AS SELECT * FROM STUDENT;

SELECT * FROM STUDENT_NEW;

----테이블 복사하기 (내용없이 구조만) WHERE 1=2 
CREATE TABLE STUDENT_NEW2
AS
    SELECT * FROM STUDENT
    WHERE 1=2;

SELECT * FROM STUDENT_NEW2;


--연습문제 p285
--1. NEW_EMP 테이블 생성
CREATE TABLE NEW_EMP(
    NO NUMBER(5),
    NAME VARCHAR(20),
    HIREDATE DATE,
    BONUS NUMBER(6,2)
);

SELECT * FROM NEW_EMP;


--2. NEW_EMP의 NO, NAME, HIREDATE 컬럼만 가져와서 NEW_EMP2 생성
CREATE TABLE NEW_EMP2
AS 
    SELECT NO, NAME, HIREDATE FROM NEW_EMP
    WHERE 1=2;

SELECT * FROM NEW_EMP2;


--3. NEW_EMP2와 구조가 같은 NEW_EMP3 생성(구조만 가져오기)
CREATE TABLE NEW_EMP3
AS 
    SELECT * FROM  NEW_EMP2
    WHERE 1=2;

SELECT * FROM NEW_EMP3;


--4. NEW_EMP2 테이블에 BIRTHDAY 컬럼 추가(기본값으로 현재 날짜 입력되도록)
ALTER TABLE NEW_EMP2 ADD(BIRTHDAY DATE DEFAULT SYSDATE);

SELECT * FROM NEW_EMP2;


--5. NEW_EMP2 테이블의 BIRTHDAY 칼럼이름을 BIRTH로 변경
ALTER TABLE NEW_EMP2 RENAME COLUMN BIRTHDAY TO BIRTH;


--6. NEW_EMP2 테이블의 NO 컬럼의 길이를 NUMBER(7)로 변경
ALTER TABLE NEW_EMP2 MODIFY NO NUMBER(7);


--7. NEW_EMP2의 BIRTH 컬럼 삭제
ALTER TABLE NEW_EMP2 DROP COLUMN BIRTH; 


--8. NEW_EMP2의 데이터만 지우는 쿼리
TRUNCATE TABLE NEW_EMP2;


--9. NEW_EMP2 완전 삭제
DROP TABLE NEW_EMP2;

SELECT * FROM NEW_EMP2;





--테이블 생성하기-제약조건 설정하기
create table new_emp1 (
   no number(4) 
   constraint emp1_no_pk primary key,
   name varchar2(20) 
   constraint emp1_name_nn not null,
   jumin varchar2(13)
   constraint emp1_jumin_nn  not null 
   constraint emp1_jumin_uk  unique,
   loc_code number(1) 
   constraint emp1_area_ck check( loc_code  <5 ) ,
   deptno varchar2(6)
   constraint emp1_deptno_fk references dept2(dcode)
);

SELECT * FROM DEPT2;
SELECT * FROM NEW_EMP1;


--제약조건에 위배되면 데이터가 들어가지 않는다

--제약조건을 만족하면 데이터가 들어감
INSERT INTO NEW_EMP1 (NO, NAME, JUMIN, LOC_CODE, DEPTNO)
VALUES(1, '홍길동', '8012102806411', 4, '1000');

SELECT * FROM NEW_EMP1;

--키 제약조건 위배 (키설정 -> 테이블내에서 유일해야하며, 널을 허용하지 않음)
INSERT INTO NEW_EMP1 (NO, NAME, JUMIN, LOC_CODE, DEPTNO)
VALUES(1, '김길동', '8112102806411', 3, '1000');

--키를 입력하지 않고 등록해보기
INSERT INTO NEW_EMP1(NAME, JUMIN, LOC_CODE, EMPTNO)
VALUES('다길동', '8112102806411', 3, '1000');

--이름없이 등록해보기
INSERT INTO NEW_EMP1(NAME, JUMIN, LOC_CODE, DEPTNO)
VALUES('2', '8212102806411', 1, '1000');

--NOT NULL이라면 반드시 값을 입력해야함
SELECT * FROM NEW_EMP1;

--주민번호가 같은 것을 등록해보기
INSERT INTO NEW_EMP1(NO, NAME, JUMIN, LOC_CODE, DEPTNO)
VALUES('2', '황길동', '8012102806411', 2, '1000');

--주민번호가 다른 것을 등록해보기
INSERT INTO NEW_EMP1(NO, NAME, JUMIN, LOC_CODE, DEPTNO)
VALUES(2,'황길동','8512102806411', 2, '1000');

--없는 부서 등록해보기
INSERT INTO NEW_EMP1(NO, NAME, JUMIN, LOC_CODE, DEPTNO)
VALUES(3, '최길동', '8612102806411', 4, '3000');

--존재하는 부서 등록하기
INSERT INTO NEW_EMP1(NO, NAME, JUMIN, LOC_CODE, DEPTNO)
VALUES(3, '최길동', '8612102806411', 4, '1000');

SELECT * FROM NEW_EMP1;


CREATE TABLE TEST_2021_2(
    ID VARCHAR2(50) NULL,
    PHONE VARCHAR2(20) CHECK(PHONE LIKE '010-%-____') NOT NULL,
    EMAIL VARCHAR2(50) NULL
);

INSERT INTO TEST_2021_2(ID, PHONE) VALUES('TEST01', '010-1234-1234');
SELECT * FROM TEST_2021_2;

--전화번호 제약조건 위배
INSERT INTO TEST_2021_2(ID, PHONE) VALUES('TEST02', '010-1234-123');

SELECT * FROM TEST_2021_2; 


CREATE TABLE TEST_2021_0(
    ID VARCHAR2(50) NOT NULL, 
    EMAIL VARCHAR2(200) NULL,
    PHONE CHAR(13) NOT NULL,
    PWD VARCHAR2(200) DEFAULT '111',
    GRADE CHAR(2) CHECK(GRADE IN('01', '02', '03'))
);

INSERT INTO TEST_2021_0(ID, PHONE, GRADE) VALUES('TEST01','010-123-1234','01');

SELECT * FROM TEST_2021_0;

--CHECK 제약조건에 없는 등급 (등록되지 않는다)
INSERT INTO TEST_2021_0(ID, PHONE, GRADE) VALUES('TEST02','010-123-1234','05');

--금액이 0이상 입력되도록 하기
--

--테이블 생성시 
--참조설정하기  (외래키 정보 설정하기 - 참조제약조건 설정하기) - 
  
  
--다른 테이블에서 참조하고 있다면 삭제가 가능한가 ? 
  
--RESTRICTED (기본값이다) -- 참조하고 있으면 삭제못함 (기본값) - 부모테이블의 행을 삭제할 수 없다 ( 나를 참조하는 값이 있으면 삭제 안됨)
--ON DELETE CASCASE   : 부모테이블의 행이 삭제되면 자식테이블의 행도 함께 삭제된다
--ON DELETE SET NULL  : 부모테이블의 행이 삭제되면 NULL로 채워진다 
    
--예시) 주문테이블에서  고객이 주문정보가 있는데  고객테이블에서 고객을 삭제할 수 있는가  여부


--고객테이블
CREATE TABLE CTBL(
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(10)
);

INSERT INTO CTBL VALUES('T1', 'KIM');
INSERT INTO CTBL VALUES('T2', 'LEE');
INSERT INTO CTBL VALUES('T3', 'PARK');

COMMIT;

SELECT * FROM CTBL;
--


--주문 테이블
CREATE TABLE OTBL(
    NO VARCHAR2(10) PRIMARY KEY,
    ID VARCHAR(10) REFERENCES CTBL(ID)
);

INSERT INTO OTBL VALUES('O001','T1');
INSERT INTO OTBL VALUES('O002', 'T1');
COMMIT;

SELECT * FROM OTBL;


--
--
CREATE TABLE CTBL2(
    ID VARCHAR(10) PRIMARY KEY,
    NAME VARCHAR2(10)
);

INSERT INTO CTBL2 VALUES('T1', 'KIM');
INSERT INTO CTBL2 VALUES('T2', 'LEE');
INSERT INTO CTBL2 VALUES('T3', 'PARK');

COMMIT;

--DROP TABLE OTBL2;

--참조하는 행이 삭제되면 함께 삭제되게 하는 설정
CREATE TABLE OTBL2(
    NO VARCHAR2(10) PRIMARY KEY,
    ID VARCHAR2(10) REFERENCES CTBL2 (ID) ON DELETE CASCADE
    -- ID VARCHAR2(10) REFERENCES CTBL2 (ID) ON DELETE SET NULL 이거는 삭제안되게 하는건가?/
);

INSERT INTO OTBL2 VALUES('O001', 'T1');
INSERT INTO OTBL2 VALUES('O002', 'T1');

COMMIT;
SELECT * FROM OTBL2;


--CTBL2에서 T1 고객 삭제 // 델프웨
DELETE FROM CTBL2 WHERE ID = 'T1';

--고객테이블
SELECT * FROM CTBL2;
SELECT * FROM OTBL2;

--참조하는 내용이 있는 경우 테이블 삭제가 되지않음
--설정을 해서 삭제해야 함
DROP TABLE CTBL2 CASCADE CONSTRAINTS;
DROP TABLE OTBL2;


--테이블 삭제시 