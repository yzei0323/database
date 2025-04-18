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



--연습문제 4. STUDENT 테이블에서 학생의 키가 동일 학년의 평균 키보다 큰 학생들의 학년과 이름, 키, 해당 학년의 평균 키 출력
--인라인 뷰를 사용 학년 컬럼으로 오름차순 정렬 출력
SELECT * FROM STUDENT;

--그냥 전체 평균키는~???
SELECT AVG(HEIGHT)
FROM STUDENT;

--학년별 평균키
SELECT GRADE, AVG(HEIGHT)
FROM STUDENT
GROUP BY GRADE
ORDER BY DESC;

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

--동우님이 한거
SELECT s.grade, s.name, s.HEIGHT, a.AVG_HEIGHT
FROM (SELECT grade, avg(height)   avg_height FROM student GROUP BY grade) A  
JOIN student  s
ON  a.grade =s.grade  AND     s.height  >= a.avg_height
ORDER BY 1;



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
SELECT TO_CHAR(PAY, '$999,999')
FROM EMP2; 
-- 999,999로 해서 그런거였음 결과값보다 작게해서..... 하 999,999,999로 해결
SELECT TO_CHAR(PAY, '$999,999,999')
FROM EMP2; 




-------- 발표
-- 420p 4번문제 동우
SELECT * FROM student ORDER BY grade;

-- 조회
SELECT grade, name, height
FROM student;

-- 학년별 키 평균
SELECT grade, avg(height)
FROM student
GROUP BY grade;

-- 평균 키보다 큰 사람 조회
SELECT grade, name, height
FROM STUDENT
WHERE height > (SELECT avg(height)
FROM student)
ORDER BY grade;

-- 학년별 평균키 보다 큰 사람 조회
SELECT grade, avg(height)
FROM student
GROUP BY grade;

SELECT s.grade, s.name, s.HEIGHT, a.AVG_HEIGHT
FROM (SELECT grade, avg(height)   avg_height
FROM student
GROUP BY grade) A  
JOIN student  s
ON  a.grade =s.grade  AND     s.height  >= a.avg_height
ORDER BY 1;


--430pg 연습문제3 윤석
SELECT * FROM STUDENT;

SELECT NAME, DEPTNO1, WEIGHT
FROM STUDENT;

-- 필요 정보
SELECT NAME, DEPTNO1, WEIGHT
FROM STUDENT
WHERE DEPTNO1 = '201';

-- 전공201의 평균 몸무게(WHERE 조건)
SELECT DEPTNO1, AVG(WEIGHT)
FROM STUDENT
WHERE DEPTNO1 = '201'
GROUP BY DEPTNO1;

SELECT AVG(WEIGHT)
FROM STUDENT
WHERE DEPTNO1 = '201';

-- 결과 출력
SELECT NAME, WEIGHT
FROM STUDENT
WHERE WEIGHT > (SELECT AVG(WEIGHT) FROM STUDENT WHERE DEPTNO1 = '201');


--434p 1번 형택

select * from emp2;

select name, pay,position
from emp2
where position = 'Section head';

select * from emp2;

select   pay 
from emp2
where position = 'Section head';

select min(pay)
from emp2
where position = 'Section head';

select name, position, pay
from emp2
where pay = (select min(pay)
             from emp2
             where position = 'Section head');
                   
select name, position, min(pay)
from emp2
where position ='Section head'
group by name, position;


select name, position, to_char(pay, '$999,999,999')as SALARY 
from emp2
where pay > (select min(pay)
            from emp2
            where position = 'Section head')
order by pay desc;
                                 

select name, position, to_char(pay, '$999,999,999') AS SALARY
from emp2
where pay >ANY   (select   pay 
from emp2
where position = 'Section head'
                  )
order by pay desc;
------------------------------
