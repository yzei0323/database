
--복수행 함수
SELECT *
FROM MEMBER_TBL_11;

--sum() : 합계 구하기
--avg() : 평균 구하기
--count() : 개수 구하기
--max () : 가장 큰 값 구하기
--min() : 가장 작은 값 구하기


--포인트 합계 구하기
--SUM(컬럼명), NULL을 제외하고 계산함

SELECT M_POINT
FROM MEMBER_TBL_11;

SELECT SUM(M_POINT)
FROM MEMBER_TBL_11;

SELECT AVG(M_POINT)
FROM MEMBER_TBL_11;

SELECT MAX(M_POINT)
FROM MEMBER_TBL_11;

SELECT MIN(M_POINT)
FROM MEMBER_TBL_11;


--COUNT() : 개수 구하기

SELECT M_POINT
FROM MEMBER_TBL_11;

--COUNT(컬럼명) : NULL 제외하고 카운트 함
SELECT COUNT(M_POINT)
FROM MEMBER_TBL_11; 


--COUNT(*) : 전체행의 개수를 반환함
SELECT COUNT(*)
FROM MEMBER_TBL_11;

SELECT COUNT(M_ID)
FROM MEMBER_TBL_11;

--테이블의 전체행의 개수를 구할 때 COUNT(*)


--GROUP BY 절
SELECT M_GRADE, M_POINT
FROM MEMBER_TBL_11;

--그룹을 만들기 전의 상태의 쿼리를 작성한다
SELECT M_GRADE, SUM(M_POINT)
FROM MEMBER_TBL_11
GROUP BY M_GRADE;

--그룹되기전의 조회 완성하기      --- 중요!!!
SELECT M_GRADE, M_POINT
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL;

--고객등급별 그룹화하기
SELECT M_GRADE, SUM(M_POINT)
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL
GROUP BY M_GRADE;


SELECT M_GRADE, AVG(M_POINT)
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL
GROUP BY M_GRADE;

SELECT M_GRADE, MAX(M_POINT)
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL
GROUP BY M_GRADE;

SELECT M_GRADE, MIN(M_POINT)
FROM MEMBER_TBL_11
WHERE M_POINT IS NOT NULL
GROUP BY M_GRADE;


--고객등급별 포인트 합계 구하기
SELECT M_GRADE M_POINT
FROM MEMBER_TBL_11;

SELECT M_GRADE M_POINT
FROM MEMBER_TBL_11
WHERE M_GRADE IS NOT NULL;

--고객등급별 포인트 합계 구하기 완성본
SELECT M_GRADE, SUM(M_POINT)
FROM MEMBER_TBL_11
WHERE M_GRADE IS NOT NULL
GROUP BY M_GRADE;


--그룹화된 결과내에서 조건을 주고 싶을 때
--필터 (HAVING절 추가): 
SELECT M_GRADE, SUM(M_POINT)
FROM MEMBER_TBL_11
WHERE M_GRADE IS NOT NULL
GROUP BY M_GRADE
HAVING SUM(M_POINT) >=5000;  --

SELECT M_GRADE, SUM(M_POINT)
FROM MEMBER_TBL_11
WHERE M_GRADE IS NOT NULL
GROUP BY M_GRADE
HAVING SUM(M_POINT) >=5000;
-- HAVING은 GROUP BY절이 있는 경우만 사용



--근데 여기 위에 뭐 더 있는데 내가 처, 노느라 빼먹엇어용 ㅋㅋ 아 

--

SELECT M_GRADE, SUM(M_POINT)
FROM member_tbl_11
WHERE M_GRADE IS NOT NULL
HAVING SUM(M_POINT)>=5000
GROUP BY M_GRADE; --결과가 나오긴 함

SELECT M_GRADE, SUM(M_POINT) AS TOTAL
FROM MEMBER_TBL_11
GROUP BY M_GRADE;

SELECT M_GRADE, SUM(M_POINT) AS TOTAL  --SELECT절의 별칭(ALIAS)은 순서적으로 SELECT절 다음부터 사용 가능
FROM MEMBER_TBL_11
GROUP BY M_GRADE
ORDER BY TOTAL;

SELECT M_GRADE, M_POINT
FROM MEMBER_TBL_11;

--그룹화
SELECT M_GRADE, SUM(M_POINT)  --3
FROM MEMBER_TBL_11   --1
GROUP BY M_GRADE;   --2

--

--그룹화
SELECT M_GRADE, SUM(M_POINT)  --4
FROM MEMBER_TBL_11   --1
GROUP BY M_GRADE   --2
HAVING SUM(M_POINT) >=5000;  --3


--그룹화
--정렬
SELECT M_GRADE, SUM(M_POINT) 
FROM MEMBER_TBL_11  
GROUP BY M_GRADE
HAVING SUM(M_POINT) >= 5000
ORDER BY 2;

--쿼리 작성의 순서 있음
--쿼리 실행의 순서 있음

SELECT *
FROM MEMBER_TBL_11;

--그룹화하기 전단계 만들기!!!
SELECT M_GRADE, M_POINT
FROM MEMBER_TBL_11;

--조건을 추가하고 싶으면 WHERE절 추가

--그룹화
SELECT M_GRADE, COUNT(M_POINT)
FROM MEMBER_TBL_11
GROUP BY M_GRADE;

--그룹화된 결과내에서 조건에 맞는거 조회하기(HAVING절 추가하기)
SELECT M_GRADE, COUNT(M_POINT)
FROM MEMBER_TBL_11
GROUP BY M_GRADE
HAVING COUNT(M_POINT) >= 3;


--위의 결과에 정렬추가하기
SELECT M_GRADE, COUNT(M_POINT) TOTAL
FROM MEMBER_TBL_11
GROUP BY M_GRADE
HAVING COUNT(M_POINT) >= 3
ORDER BY 2 DESC;

SELECT M_GRADE, COUNT(M_POINT) TOTAL
FROM MEMBER_TBL_11
GROUP BY M_GRADE
HAVING COUNT(M_POINT) >= 3
ORDER BY TOTAL;


