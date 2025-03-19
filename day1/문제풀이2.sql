
CREATE TABLE CUST_INFO(
 ID VARCHAR2(13) NOT NULL PRIMARY KEY ,
 FIRST_NM  VARCHAR2(10)   ,
 LAST_NM   VARCHAR2(10)   ,
 ANNL_PERF NUMBER(10,2)  
);
 COMMIT;
 
INSERT INTO CUST_INFO VALUES ('8301111567897' , 'JIHUN' , 'KIM', 330.08);
INSERT INTO CUST_INFO VALUES ('9302112567897' , 'JINYOUNG' , 'LEE', 857.61);
INSERT INTO CUST_INFO VALUES ('8801111567897' , 'MIJA' , 'HAN', -76.77);
INSERT INTO CUST_INFO VALUES ('9901111567897' , 'YOUNGJUN' , 'HA', 468.54);
INSERT INTO CUST_INFO VALUES ('9801112567897' , 'DAYOUNG' , 'SUNG', -890);
INSERT INTO CUST_INFO VALUES ('9701111567897' , 'HYEJIN' , 'SEO', 47.44);
COMMIT;

select *
from cust_info;


--<문자함수>
--문제) 고객정보 테이블로부터 주민번호 7번째 숫자 (성별을 나타내는)를 추출하여 GENDER 라는 이름으로 주민번호와 함께 조회하시오
select substr(id, 7, 1) as gender -- (칼럼, 시작인덱스, 반환개수) 그니까 7부터 1개 반환하는거임
from cust_info;

--문제) 고객정보 테이블로부터  주민번호,  LAST_NM을 모두 소문자로 조회되도록 하시오
select lower(id), lower(last_nm)
from cust_info;

--문제) 고객정보 테이블로부터 DM발송을 위해서  NAME이라는 이름으로 KIM, JIHOON 과 같은형식으로 조회될 수 있도록 하시오
select last_nm||','||first_nm name
from cust_info;


--<숫자함수>
--문제) 고객정보 테이블로부터 고객 주민번호, 수익을 소수 둘째에서 반올림하여 소수 첫째자리까지 표시될 수 있도록 조회 하시오
select id, round(annl_perf,1)
from cust_info;
--반올림함수 round(값, 표시될 숫자 개수)

--문제) 고객정보 테이블로부터 고객 주민번호, 수익을 소수 첫째에서 버림하여 정수로 나타낼수 있도록 조회하시오
select id, trunc(annl_perf,0)
from cust_info;
--버림함수? trunc(값, 표시될 숫자 개수)


--<날짜함수>
--문제)현재날짜를 조회하시오
SELECT SYSDATE FROM DUAL;
SELECT 2+3 FROM DUAL; 
--헐 ~~~ 대박 똑똑해


--<조건식>
--문제) 고객테이블로부터 주민번호 , 수익이 300이상이면 고수익 100이상은 일반수익 0이하이면 손해 , 나머지는 변동없음 내용이 RESULT컬럼명으로 조회될 수 있도록 하시오
select id, case 
when substr(annl_perf,1) >= 300 then '고수익'
when substr(annl_perf,1) >= 100 then '일반수익'
when substr(annl_perf,1) <= 0 then '손해'
else '변동없음'
end "result"
from cust_info;


--<기타함수> NVL, NYL2 함수
--NVL : NULL 값 대신 특정값으로 대체하고 싶은 값을 지정할 때 사용한다 NVL(컬럼, NULL인 경우 대체하고 싶은 값)
--NVL2 : NULL 값과 NULL 값이 아닌경우 대체하고 싶은 값을 지정할 때 사용한다  NVL2( 컬럼, NULL이아닌경우, NULL인 경우)

--문제) 고객테이블로부터 이름과 포인트를 조회하시오 (단 포인트가 적립되지 않은 고객은 0으로 표시되도록 하시오)  힌트:NVL 함수 사용



--문제) 힌트: NVL2함수를 사용하세요
--고객테이블로부터 기존포인트 점수에서 100포인트씩 인상하려고 합니다.  NEXT_POINT라는 컬럼으로 조회되도록 하시오, 고객이름, 포인트와 함께 조회하시오 ( 기존포인트가 없는 사람은 0포인트로 간주합니다 