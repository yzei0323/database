create table goods_tbl_500(
goods_cd varchar2(6) not null primary key, 
goods_nm varchar2(30), 
goods_price number(8), 
cost number(8), in_date date
); 


insert into goods_tbl_500 values('110001','육계장사발면',1050,750,'20190302');
insert into goods_tbl_500 values('110002','단팥빵',1300,800,'20190302'); 
insert into goods_tbl_500 values('110003','사브로',2000,1700,'20190302');
insert into goods_tbl_500 values('110004','칠성사이다',900,750,'20190302'); 
insert into goods_tbl_500 values('110005','콜라',750,300,'20190302'); 
insert into goods_tbl_500 values('110006','아몬드초콜릿',1500,1300,'20190302'); 
insert into goods_tbl_500 values('110007','초코몽',850,600,'20190302');


create table store_tbl_500(
store_cd varchar2(5) not null primary key,
store_nm varchar2(20), 
store_fg varchar2(1)
);

insert into store_tbl_500 values('A001','노원점','0');
insert into store_tbl_500 values('A002','마포점','0'); 
insert into store_tbl_500 values('A003','석계점','0'); 
insert into store_tbl_500 values('B001','하계점','1');
insert into store_tbl_500 values('C001','상계점','1'); 
insert into store_tbl_500 values('D001','중계점','0');
insert into store_tbl_500 values('D002','태릉입구점','1'); 
insert into store_tbl_500 values('E001','화랑대점','0');


 create table sale_tbl_500(
 sale_no varchar2(4) not null primary key, 
 sale_ymd date not null,
 sale_fg varchar2(1) not null, 
 store_cd varchar2(5)  ,         
 goods_cd varchar2(6) ,
 sale_cnt number(3),
 pay_type varchar2(2),
 constraint  fk1 foreign key (store_cd)  references store_tbl_500(store_cd),
 constraint  fk2  foreign key (goods_cd) references goods_tbl_500(goods_cd)
); 

insert into sale_tbl_500 values('0001','20190325','1','A001','110001',2,'02'); 
insert into sale_tbl_500 values('0002','20190325','1','B001','110003',2,'02');
insert into sale_tbl_500 values('0003','20190325','1','D001','110003',1,'01'); 
insert into sale_tbl_500 values('0004','20190325','1','A001','110006',5,'02'); 
insert into sale_tbl_500 values('0005','20190325','1','C001','110003',2,'02'); 
insert into sale_tbl_500 values('0006','20190325','2','C001','110003',2,'02');
insert into sale_tbl_500 values('0007','20190325','1','A002','110005',4,'02');
insert into sale_tbl_500 values('0008','20190325','1','A003','110004',4,'02');
insert into sale_tbl_500 values('0009','20190325','1','B001','110001',2,'01');
insert into sale_tbl_500 values('0010','20190325','1','A002','110006',1,'02');

 

SELECT * FROM GOODS_TBL_500;
SELECT * FROM STORE_TBL_500;
SELECT * FROM SALE_TBL_500;

--업셋웨
UPDATE GOODS_TBL_500 SET IN_DATE='20200110';
UPDATE STORE_TBL_500 SET STORE_NM='화랑점' WHERE STORE_CD='E001';
UPDATE SALE_TBL_500 SET SALE_YMD='20201210';


--점포별 매출현황
--점포명, 현금매출, 카드매출, 총매출
SELECT ST.STORE_NM, SUM(SA.SALE_CNT) 판매수량
FROM SALE_TBL_500 SA
JOIN STORE_TBL_500 ST
ON SA.STORE_CD = ST.STORE_CD
GROUP BY ST.STORE_NM;

-- 그니까 판매된 싱품코드랑,. 이름이랑... 개수랑.. 가격?
SELECT  SA.GOODS_CD, G.GOODS_NM, SUM(SA.SALE_CNT) 판매개수
FROM GOODS_TBL_500 G
JOIN SALE_TBL_500 SA
ON G.GOODS_CD = SA.GOODS_CD
GROUP BY SA.GOODS_CD, G.GOODS_NM;

SELECT  SA.GOODS_CD, G.GOODS_NM, SUM(SA.SALE_CNT) 판매개수, 
        G.GOODS_PRICE*SA.SALE_CNT 판매금액 
FROM GOODS_TBL_500 G
JOIN SALE_TBL_500 SA
ON G.GOODS_CD = SA.GOODS_CD
GROUP BY SA.GOODS_CD, G.GOODS_NM, G.GOODS_PRICE*SA.SALE_CNT;
-- 아니 개수에 SUM 해야될것같은데 이거 어케해??
