select * from student;


create table  acorntb (
    id  varchar2(10) primary key,
    pw  varchar2(10) ,
    name varchar2(10)
);

select *  from acorntbl ;
insert into acorntbl values('usung0518', '1234', '권지언'); 
insert into acorntbl values('boseong00', '1234', '김보성'); 
insert into acorntbl values('Jys123', '9876', '정연수');
insert into acorntbl values('sumni', '1234', '이수민');
insert into acorntbl values('dongwoo12', '1234', '이동우');
insert into acorntbl values('gusrl123', 'dks123', '윤현기');
insert into acorntbl values('sulivun_03', '1234', '박시우');
insert into acorntbl values('yerin0373', '1234', '박예린'); 
insert into acorntbl values('yzei', '1234', '황예지'); 
insert into acorntbl values('jitae', '1214', '최지태'); 
insert into acorntbl values('sookyung', '1004', '박수경'); 
insert into acorntbl values('yunseok', '123', '오윤석');
insert into acorntbl values('LHJ0319', '1234', '이정호'); 
insert into acorntbl values('gudxor8251', '1234', '임형택'); 
insert into acorntbl values('che', '1234', '최하은');
insert into acorntbl values('umin', '1234', '김유민');
insert into acorntbl values('gill', '0000', '김민환');
insert into acorntbl(id) values('test');
commit;

delete from acorntbl where id='test';
update acorntbl set name='정연수' where id='Jys123';
update acorntbl set name='이정호' where id='LHJ0319';

--테이블의 전체 칼럼 조회하기
select * from acorntbl

--특정칼럼 조회하기
select id, name from acorntbl;

--정렬하기
select id,pw
from acorntbl
order by pw desc;

--정렬하기
--정렬기준을 조회칼럼의 순서를 사용할 수 있음
select id, pw
from acorntbl
order by 2;

-- || 연결연산자
-- 데이터베이스 문자, 날짜, 데이터는 ' ' 
select name || '님'
from acorntbl;

--비밀번호 조회
select pw
from acorntbl;

--비밀번호 조회(중복제거)
select distinct pw
from acorntbl;



create table  acorntbl2 (
    id  varchar2(10) primary key,
    pw  varchar2(10) ,
    name varchar2(10),
    point number(6) 
);

select *  from acorntbl2 ;
insert into acorntbl2 values('usung0518', '1234', '권지언', 1500); 
insert into acorntbl2 values('boseong00', '1234', '김보성', 3000); 
insert into acorntbl2 values('Jys123', '9876', '정연수', 4000);
insert into acorntbl2 values('sumni', '1234', '이수민', 2000);
insert into acorntbl2 values('dongwoo12', '1234', '이동우', 1000);
insert into acorntbl2 values('gusrl123', 'dks123', '윤현기', 5000);
insert into acorntbl2 values('sulivun_03', '1234', '박시우', 3400);
insert into acorntbl2 values('yerin0373', '1234', '박예린', 1200); 
insert into acorntbl2 values('yzei', '1234', '황예지', 6500); 
insert into acorntbl2 values('jitae', '1214', '최지태', 4500); 
insert into acorntbl2 values('sookyung', '1004', '박수경',200); 
insert into acorntbl2 values('yunseok', '123', '오윤석', 700);
insert into acorntbl2 values('LHJ0319', '1234', '이정호', 5000); 
insert into acorntbl2 values('gudxor8251', '1234', '임형택', 2800); 
insert into acorntbl2 values('che', '1234', '최하은', 7800);
insert into acorntbl2 values('umin', '1234', '김유민', 4900);
insert into acorntbl2 values('gill', '0000', '김민환' ,5900);
insert into acorntbl2 (id) values('test');
commit;


--특정조건으로 조회하기
--where절 사용하기

-- = (같다)
select id, pw, name
from acorntbl2
where name='권지언';

-- > (크다)
select id, name, point
from acorntbl2
where point > 5000;

-- >= (이상)
select id, name, point
from acorntbl2
where point >= 3000;

-- < (작다)
select id, name, point
from acorntbl2
where point < 1000;

-- <= (이하)
select id, name, point
from acorntbl2
where point <= 3000;


-- between a AND b  ( a가 더 작은값이어야 한다 a, b 포함된다)
-- 2000 ~ 3000 사이의 회원정보 조회하기
select id, name, point
from acorntbl2
where point between 2000 AND 3000;


--조건이 여러개 있을 때  AND (그리고)
--비밀번호가 1234이고 포인트가 3000 이상인 사람 조회하기
select id, pw, name, point
from acorntbl2
where pw='1234' AND point >= 3000;
--포인트가 2000보다 크고 3000보다 작은 사람 조회하기
select id, pw, name, point
from acorntbl2
where point>2000 AND point<3000;

--조건이 여러개 있을 때  OR (이거나)
--포인트가 1000 미만이거나 포인트가 5000이상인 회원 조회하기
select id, pw, name, point
from acorntbl2
where point < 1000 or point >= 5000;


-- in (  ) : 괄호 안에 있는 것만 조회할 때
select id, pw, name, point
from acorntbl2
where pw in ('1234', '123');

-- not in () 괄호 안에 있는 것만 제외하고 조회할 때
select id, pw, name, point
from acorntbl2
where pw not in ('1234', '123');

-- null : 값이 정해지지 않음을 의미하는 값
-- 등록(insert)할 때 해당 컬럼이 등록되지 않으면 null로 채워짐
-- null 체크할 때는 같다 =, 같지않다 != 사용할 수 없다
-- is null과 is not null 사용해야 함

-- is null  (null값을 조회)
select id, pw, name, point
from acorntbl2
where point is null;

-- is not null (null이 아닌 값을 조회)
select id, pw, name, point
from acorntbl2
where point is not null;


-- 같지 않다 !=
select id, pw, name, point
from acorntbl2
where pw != '1234';




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


select *
from member_tbl_11
where m_birthday > '2004-09-12';  -- 날짜데이터도 ' ' 감싼다

select *
from member_tbl_11
where m_birthday >= '04/12/10';  -- 날짜데이터도 ' ' 감싼다

select m_grade
from member_tbl_11;

-- 중복된 값 제외하고 조회 distinct
select distinct m_grade
from member_tbl_11;


-- 특정패턴을 가지고 있는 것을 조회할 때 사용
-- Like
-- % , _(한 문자 의미)

-- 이씨 성을 가진 사람을 조회
select *
from member_tbl_11
where m_name like '이%';


-- 김씨 성을 가진 사람을 조회
select *
from acorntbl2
where name like '김%';

-- 이름에 지가 포함된 사람을 조회
select *
from acorntbl2
where name like '%지%';

-- 이름이 우로 끝나는 사람을 조회
select *
from acorntbl2
where name like '%우';


-- _ (한 문자만 의미)
select *
from acorntbl2
where name like '김_';

select *
from acorntbl2
where name like '김__';

--
desc acorntbl2;

insert into acorntbl2 values('test2', '0000', '김솔', 8000);
commit; 
