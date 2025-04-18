--데이터베이스 2차시

-- 문자함수
-- CONCAT()함수   연결함수, || 연산자와 동일

SELECT *
FROM EMP;

SELECT ENAME || ' ' || JOB
FROM EMP;

SELECT CONCAT(ENAME, JOB)
FROM EMP;

SELECT CONCAT(ENAME, '님')
FROM EMP;


-- SUBSTR() : 문자열의 일부를 가져올 때
SELECT SUBSTR('0201064234567' , 7, 1)
FROM DUAL;


-- INSTR() : 문자열에서 특정 문자의 위치를 반환
SELECT INSTR('02)987-1258', ')')
FROM DUAL;


-- LPAD() 전체자리수에서 왼쪽부터 원하는 문자로 채운다
SELECT ID FROM STUDENT;
SELECT PW FROM ACORNTBL2;

SELECT LPAD(ID, 10, '0') FROM STUDENT;
SELECT RPAD(ID, 10, '*') FROM ACORNTBL2;


-- TRIM() , LTRIM(), RTRIM() 공백제거, 특정문자 제거
SELECT *
FROM ACORNTBL2;

SELECT NAME, TRIM(NAME)
FROM ACORNTBL2;


-- REPLACE() : 문자열에서 문자1, 문자2로 변환해줌
SELECT *
FROM ACORNTBL2;

SELECT PW, REPLACE(PW, '1234', '****')
FROM ACORNTBL2;

--
SELECT REPLACE(NAME, '김', 'KIM')
FROM ACORNTBL2;


--이름의 첫글자가 별로 REPLACE 되도록 하기
SELECT REPLACE(NAME, '이', '*')
FROM ACORNTBL2;

SELECT REPLACE(NAME, '오', '*')
FROM ACORNTBL2;

--이름의 첫글자만 가져오기 SUBSTR 이용하기
SELECT SUBSTR(TRIM(NAME), 1, 1)
FROM ACORNTBL2;

SELECT REPLACE(NAME, SUBSTR(NAME,1,1),'*')
FROM ACORNTBL2;

--성만 보이게 하기 이름을 **로
SELECT SUBSTR(NAME, 2, 2)
FROM ACORNTBL2;

SELECT REPLACE(NAME, SUBSTR(NAME,2,2),'**')
FROM ACORNTBL2;


--교재84
--REPLACE 퀴즈1
--EMP 테이블에서 20번 부서에 소속된 직원들의 이름을 2~3번째 글자만 -으로 변경해서 출력
SELECT *
FROM EMP;

SELECT ENAME, REPLACE(ENAME, SUBSTR(ENAME,2,2),'--') AS REPLACE
FROM EMP
WHERE DEPTNO = '20';

--REPLACE 퀴즈2
--STUDENT 테이블에서 1전공이 101인 학생들의 이름과 주민등록번호 뒷자리는 -,/로 출력
SELECT NAME, JUMIN, REPLACE(JUMIN,SUBSTR(JUMIN,-7,7),'-/-/-/-') REPLACE
FROM STUDENT
WHERE DEPTNO1 = '101';

--REPLACE 퀴즈3
--STUDENT 테이블에서 1전공이 102번인 학생들의 이름과 전화번호에서 국번부분만 *처리해서 출력
SELECT *
FROM STUDENT;

SELECT NAME, TEL, REPLACE(TEL, SUBSTR(TEL,5,3),'***') AS REPLACE
FROM STUDENT
WHERE DEPTNO1 = '102';

--REPLACE 퀴즈4
--STUDENT 테이블에서 1전공이 101번인 학생들의 이름과 전화번호에서 끝 네자리만 *처리해서 출력
SELECT NAME, TEL, REPLACE(TEL, SUBSTR(TEL, 9, 4), '****') AS REPLACE
FROM STUDENT
WHERE DEPTNO1 = '101';

-- 마이너스로 붙이면 오->왼 검색하고 글자 수 세는건 왼->오임 몬말알?? 밑에처럼 하면됨
SELECT NAME, TEL, REPLACE(TEL, SUBSTR(TEL, -4, 4), '****') AS REPLACE
FROM STUDENT
WHERE DEPTNO1 = '101';

--교재82 RPAD퀴즈
--DEPTNO 10번인 사원 이름을 9자리로 출력 빈자리에는 자릿수에 맞는 숫자 출력
SELECT * FROM EMP WHERE DEPTNO='10';

SELECT RPAD(ENAME, 9, SUBSTR(123456789, LENGTH(ENAME)+1)) REPLACE
FROM EMP
WHERE DEPTNO = '10';

-- (-시작위치 : 오른쪽)
SELECT TEL, SUBSTR(TEL,-4,4)
FROM STUDENT;

SELECT TEL, SUBSTR(TEL, -4)  --그 위치에서 전부 다 가져옴
FROM STUDENT;

--숫자관련함수
-- ROUND, TRUNC, FLOOR, CEIL, MOD
SELECT 987.56 FROM DUAL;
SELECT ROUND(987.56) FROM DUAL; --988
SELECT ROUND(987.56, 1) FROM DUAL; --987.6
SELECT ROUND(987.56, -1) FROM DUAL; --990

SELECT 987.56 FROM DUAL;
SELECT TRUNC(987.56) FROM DUAL;  --987
SELECT TRUNC(987.56, 1) FROM DUAL;  --987.5
SELECT TRUNC(987.56, -1) FROM DUAL;  --980

--FLOOR, CEIL
SELECT FLOOR(5.65) FROM DUAL;  --5
SELECT CEIL(5.65) FROM DUAL;  --6

SELECT FLOOR(-5.65) FROM DUAL;  -- -5 -6
SELECT CEIL(-5.65) FROM DUAL;   -- -5 -6

--MOD
SELECT MOD(10,3) FROM DUAL;

--POWER()
SELECT POWER(2,3) FROM DUAL;


--날짜관련함수
--현재날짜구하기
SELECT SYSDATE FROM DUAL;

--개월수구하기
SELECT MONTHS_BETWEEN('2025-3-20', '2025-01-07') FROM DUAL;

--마지막날 구하기
SELECT LAST_DAY('2025-03-20') FROM DUAL;

--ADD_MONTHS : 주어진 날짜에 숫자만큼 달을 추가
SELECT ADD_MONTHS('2025-03-20', 4) FROM DUAL;


--형변환함수
--묵시적형변환
SELECT 2+'2' FROM DUAL;

--'2' -> 숫자로 묵시적형변환
SELECT 2+TO_NUMBER('2') FROM DUAL;

--
SELECT *
FROM MEMBER_TBL_11;

--BETWEEN
SELECT *
FROM MEMBER_TBL_11
WHERE M_BIRTHDAY BETWEEN '2004-01-01' AND '2004-01-31' ;

-- '2024-01-01' 값이 묵시적으로 날짜형으로 변환됨
SELECT *
FROM MEMBER_TBL_11
WHERE M_BIRTHDAY BETWEEN TO_DATE('2004-01-01') AND TO_DATE('2004-01-31');


--명시적형변환
-- TO_DATE() : 날짜로 변환 (날짜형식의 문자열을 날짜데이터로 변환)
-- TO_CHAR() : 문자로 변환 (날짜를 특정 포맷으로 조회할 때, 숫자를 원하는 형식으로 조회할 때)
-- TO_NUMBER() : 숫자로 변환 (숫자형식을 가진 문자를 숫자로 변환)

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

--년도
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY')
FROM DUAL;

--월
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MM')
FROM DUAL;

--전체월 정보
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MON')
FROM DUAL;

--일
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD')
FROM DUAL;

--요일
SELECT SYSDATE, TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

--
SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"일"DD"일"') FROM DUAL;

-- MEMBER_TBL_11 테이블에서 1월생 조회
SELECT M_BIRTHDAY
FROM MEMBER_TBL_11;

SELECT M_BIRTHDAY, TO_CHAR(M_BIRTHDAY, 'MM')
FROM MEMBER_TBL_11;

SELECT M_BIRTHDAY, TO_CHAR(M_BIRTHDAY, 'MM')
FROM MEMBER_TBL_11
WHERE TO_CHAR(M_BIRTHDAY,'MM')='01';


--숫자를 문자로 변환
SELECT 25600 FROM DUAL;
SELECT TO_CHAR(25600, '999,999') FROM DUAL;
SELECT TO_CHAR(25600, '0999,999') FROM DUAL; -- 의미 없는 0 표시
SELECT TO_CHAR(25600, '$999,999') FROM DUAL; -- $25,600
SELECT TO_CHAR(25600, 'L999,999') FROM DUAL; -- ￦25,600
SELECT TO_CHAR(25600, 'L999,999.99') FROM DUAL; -- ￦25,600.00


--TO_NUMBER() 숫자로 바뀌는거임?
SELECT TO_NUMBER('1200'), TO_NUMBER('1200')+100  FROM DUAL;

--TO_DATE() : 날짜형식으로 변환
SELECT TO_DATE('2025-03-20') FROM DUAL; 


--일반함수
--DECODE
--NVL, NVL2

--M_GRADE
SELECT M_NAME, M_GRADE
FROM MEMBER_TBL_11;

--01: VVIP
--02: VIP
--03: BRONZE

SELECT M_NAME, M_GRADE, DECODE(M_GRADE,'01','VVIP','02','VIP','03','BRONZE','대상아님') GRADE
FROM MEMBER_TBL_11;


--DECODE문제
--교재 114 유형문제1
--PROFESSOR 테이블에서 학과번호와 교수명, 학과명을 출력하되 DEPTNO가 101인 교수만 
--학과명을 Computer Engineering으로 출력하고  나머지는 학과명에 아무것도 출력하지 마세요 ㅇㅋ

SELECT * FROM PROFESSOR;

SELECT DEPTNO, NAME, DECODE(DEPTNO,'101','Computer Engineering',' ') AS DNAME
FROM PROFESSOR;

--유형문제2
--1번 문제에서 아무것도 출력 안했던 그부분에 ETC 출력해라
SELECT DEPTNO, NAME, DECODE(DEPTNO,'101','Computer Engineering','ETC') AS DNAME
FROM PROFESSOR;

--유형문제3
--101은 컴퓨터 102는 멀티미디어 103은 소프트웨어
SELECT DEPTNO, NAME, DECODE(DEPTNO,'101','Computer Engineering',
'102','Multimedia Engineering','103','Software Engineering','ETC') AS DENAME
FROM PROFESSOR;

--유형문제4
--PROFESSOR 테이블에서 교수 이름과 부서번호 출력 101번 부서 중에 Audie Murphy 교수에게 BEST라고 출력
--나머지는 NULL값 출력 101번 부서 Audie Murphy 교수한테만 BEST! 출력
SELECT DEPTNO, NAME, DECODE(DEPTNO,101,DECODE(NAME,'Audie Murphy','BEST!',' '),' ') ETC
FROM PROFESSOR;


--페이지120
--DECODE 퀴즈1
--STDENT 테이블에서 1전공이 101인 학생들의 이름과 주민번호, 성별 출력 주민번호 이용하여 MAM, WOMAN 출력
SELECT * FROM STUDENT;

SELECT NAME, JUMIN, DECODE(SUBSTR(JUMIN,7,1),1,'MAN',2,'WOMAN') Gender
FROM STUDENT
WHERE DEPTNO1='101';

--아 이거는 다 출력하게되는거임 아 오키오키 바보였다
SELECT NAME, JUMIN, DECODE(DEPTNO1,'101',DECODE(SUBSTR(JUMIN,7,1),1,'MAN',2,'WOMAN')) Gender
FROM STUDENT;

--DECODE 퀴즈2
--STUDENT 테이블에서 1전공인 101인 학생의 이름과 연락처, 지역 출력
--지역번호 02는 SEOUL, 031은 GYEONGGI, 051은 BUSAN, 052는 ULSAN, 055는 GYEONGNAM
SELECT NAME, TEL, DECODE(SUBSTR(TEL,1,INSTR(TEL,')')-1),'02','SEOUL',
'031','GYEONGGI','051','BUSAN','052','BUSAN','055','GYEONGNAM')
FROM STUDENT
WHERE DEPTNO1='101';


--NVL
--NVL2

--NULL
SELECT * FROM MEMBER_TBL_11;

-- 100+1000 => 1100
-- NULL(값이 정해지지 않은 상태)+1000 => NULL
-- NULL에 연산을 하면 결과가 NULL이다

SELECT M_POINT +1000
FROM MEMBER_TBL_11;

SELECT NVL(M_POINT, 0) FROM MEMBER_TBL_11; --NULL이면 값을 0으로 해라

--NVL2(NULL이 아닐 때, NULL일 때)
SELECT M_POINT, NVL(M_POINT+100, 200)
FROM MEMBER_TBL_11;


-- CASE WHEN
SELECT M_POINT
FROM MEMBER_TBL_11;

SELECT M_POINT, CASE WHEN M_POINT >=3000 THEN '상'
                     WHEN M_POINT >=2000 THEN '중'
                     ELSE '하'
                END AS "RESULT !!"  --별칭을 줄 때 스페이스나 대소문자 구분하고 싶으면 ""감싸면됨
FROM MEMBER_TBL_11;



