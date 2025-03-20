-- 두번째
-- 1. 고객등급이 ‘01’이고 포인트가 2000이상인 고객의 아이디, 이름 정보를 조회하시오
select m_id, m_name
from member_tbl_11
where m_grade='01' and m_point>=2000; 

-- 2. 고객등급이 ‘01’ 이거나 포인트가 2000이상인 고객의 아이디, 이름 정보를 조회하시오
select m_id, m_name
from member_tbl_11
where m_grade='01' or m_point>=2000;

-- 3. 김씨성을 가진 고객의 아이디, 이름, 등급 정보를 조회하시오 (예) 김길동, 김홍식 , 김지성... 김으로 시작되는 이름)
select m_id, m_name, m_grade
from member_tbl_11
where m_name like '김%';

-- 4. 이름이 수로 끝나는 고객의 아이디, 이름 , 등급 정보를 조회하시오
select m_id, m_name, m_grade
from member_tbl_11
where m_name like '%수';

-- 5. 고객등급이 ‘01’, ‘03’ 인 고객의 아이디, 이름, 등급 정보를 조회하시오 (IN 연산자 사용해 주세요)
select m_id, m_name, m_grade
from member_tbl_11
where m_grade in ('01', '03');

-- 6. 고객등급이 ‘01’, ‘02’ 이 아닌 고객의 아이디, 이름, 등급 정보를 조회하시오 (NOT IN 연산자 사용 해 주세요)
select m_id, m_name, m_grade
from member_tbl_11
where m_grade not in ('01', '02');

-- 7. 고객등급이 ‘02’ 이거나 이름이 이씨성을 가진 고객의 정보의 아이디와 이름 , 등급 정보를 조회 하시오
select m_id, m_name, m_grade
from member_tbl_11
where m_grade='02' or m_name like '이%';

-- 8. 생일이 2004-05-01이전에 태어나거나 고객등급이 ‘03’인 고객의 아이디, 이름, 생일 정보를 조회하시오
select m_id, m_name, m_birthday
from member_tbl_11
where m_birthday < '04/05/01' or m_grade='03';


--문제) MEMBER_TBL_11 테이블로부터 고객등급 조회하기
SELECT M_GRADE 
FROM MEMBER_TBL_11 ;

--문제) MEMBER_TBL_11 테이블로부터 고객등급 조회하기, 중복된 값 제외하고 조회하기
select distinct m_grade
from member_tbl_11;

--문제) 고객테이블로부터 아이디  USERID라는 이름으로 조회하기 (AS 는 생략가능함)
select m_id USERID
from member_tbl_11;

--문제) 고객테이블로부터 이름에 ‘님’자를 붙여 NAME이라는 컬럼으로이 조회되도록 하시오
select m_name || '님' as name
from member_tbl_11;

SELECT CONCAT(M_NAME,'님') NAME
FROM MEMBER_TBL_11;