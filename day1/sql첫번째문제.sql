
create table member_tbl_11(
 m_id   varchar2(5) not null  primary key ,
 m_pw  varchar2(5)  ,
 m_name varchar2(10) ,
 m_tel varchar2(13) ,
 m_birthday date ,
 m_point  number(6) ,
 m_grade varchar2(2) 
);
commit;


insert into member_tbl_11 values ('m100' , '1234' , '성기훈', '010-1111-2222' , '2004-01-01' , 100,  '01');
insert into member_tbl_11 values ('m101' , '4444' , '김상우', '010-2222-3333' , '2004-01-01' , 1500, '01');
insert into member_tbl_11 values ('m102' , '5555' , '김일남', '010-3333-4444' , '2004-12-10' , 2000, '02');
insert into member_tbl_11 values ('m103' , '6666' , '이준호', '010-4444-5555' , '2004-04-10' , 1900, '02');
insert into member_tbl_11 values ('m104' , '7777' , '김새벽', '010-5555-6666' , '2004-09-12' , 3000, '03');
insert into member_tbl_11 values ('m105' , '8888' , '최덕수', '010-6666-7777' , '2004-08-10' , 4800, '03');
insert into member_tbl_11 values ('m106' , '9999' , '이알리', '010-7777-8888' , '2004-07-10' , 2900, '01');
insert into member_tbl_11 values ('m107' , '0101' , '김미녀', '010-8888-9999' , '2004-06-09' , 1200, '01');
insert into member_tbl_11 values ('m108' , '0404' , '이정재', '010-9999-8888' , '2004-05-19' , 3000, '03');

insert into member_tbl_11 ( m_id, m_pw, m_name , m_tel , m_birthday)
values ('m109' , '0448' , '박해수', '010-7878-1111' , '2004-11-27' );

insert into member_tbl_11 ( m_id, m_pw, m_name , m_tel , m_birthday) 
values ('m110' , '4848' , '위하준', '010-8888-9090' , '2004-11-09');

commit;


-- 첫번째
-- 1. 모든 정보조회(* : 모든컬럼)
select * from member_tbl_11;

-- 2. 모든 고객의 이름과 생일 정보 조회하시오
select m_name, m_birthday
from member_tbl_11;

-- 3. 이름이 박해수인 고객아이디, 생일, 포인트  정보 조회하시오 
select m_id, m_birthday, m_point
from member_tbl_11
where m_name='박해수';

-- 4. 포인트가 2000점 이상인 고객이름, 전화번호  정보 조회하시오
select m_name, m_tel
from member_tbl_11
where m_point >= 2000;

-- 5. 포인트가 2000점에서 3000점 사이의 고객이름, 전화번호 정보 조회하시오
select m_name, m_tel, m_point
from member_tbl_11
where m_point between 2000 and 3000;

select m_name, m_tel, m_point
from member_tbl_11
where m_point>=2000 and m_point<=3000;

-- 6. 고객등급이 ‘01’인 고객이름, 전화번호 , 포인트 정보 조회하시오
select m_name, m_tel, m_point
from member_tbl_11
where m_grade = '01';

-- 7. 생일이 2004-06-01 이후인 고객이름, 전화번호 정보 조회하시오
select m_name, m_tel
from member_tbl_11
where m_birthday > '2004-06-01';

-- 8. 생일이 2004-05-01 이전에 태어난 고객의 고객이름 , 생일 정보 조회하시오
select m_name, m_birthday
from member_tbl_11
where m_birthday < '04/05/01';

-- 9. 고객등급이 ‘01’이 아닌 고객의 고객이름, 전화번호, 고객등급 정보 조회하시오
select m_name, m_tel, m_grade
from member_tbl_11
where m_grade != '01';

-- 10. 고객 등급이 ‘02’ 인  고객의 고객아이디, 이름, 전화번호 정보 조회하시오
select m_id, m_name, m_tel
from member_tbl_11
where m_grade = '02';

-- 11. 포인트가 1500점 미만인  고객의  고객이름, 전화번호 조회하시오
select m_name, m_tel
from member_tbl_11
where m_point < 1500;

-- 12. 포인트가 적립되지 않은 고객정보 조회하시오 ( 포인트가  NULL인 고객 조회: 포인트가 입력되지 않은 고객을 말함 )  
select *
from member_tbl_11
where m_point is null;

-- 13. 포인트가 부여된 (포인트 금액을 가지고 있는) 고객정보 조회하시오( 포인트가 NULL이 아닌 고객 조회하면 됨)
select *
from member_tbl_11
where m_point is not null; 

-- 14. 고객등급이 중복되지 않도록 고객등급을 조회하는 쿼리를 작성하시오
select distinct m_grade
from member_tbl_11;




