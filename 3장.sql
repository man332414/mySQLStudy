create database market_db;

use market_db;
show tables;
desc member;
select * from member;
use login_crud;
drop database test9;

-- use 명령어를 사용하면 테이블 이름만 명시해도 된다.
use market_db;
select * from member;
-- use 명령어를 사용하지 않으면 테이블 이름만으로 검색할 수 없음
select * from market_db.member;

CREATE TABLE member -- 회원 테이블
( mem_id  		CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  mem_name    	VARCHAR(10) NOT NULL, -- 이름
  mem_number    INT NOT NULL,  -- 인원수
  addr	  		CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  phone1		CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2		CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height    	INT,  -- 평균 키
  debut_date	DATE  -- 데뷔 일자
);

alter table member change height height int;

CREATE TABLE buy -- 구매 테이블
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   mem_id  	CHAR(8) NOT NULL, -- 아이디(FK)
   prod_name 	CHAR(6) NOT NULL, --  제품이름
   group_name 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 가격
   amount    	INT  NOT NULL, -- 수량
   FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

alter table buy change amount amount int;

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015.10.19');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울', NULL, NULL, 160, '2015.04.21');
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
INSERT INTO member VALUES('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
INSERT INTO member VALUES('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
INSERT INTO member VALUES('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
INSERT INTO member VALUES('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
INSERT INTO member VALUES('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');

INSERT INTO buy VALUES(NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', '혼공SQL', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 4);

SELECT * FROM member;
SELECT * FROM buy;

select mem_name from member;

select addr "주소", debut_date "데뷔날짜", mem_name "멤버이름" from member order by "데뷔날짜" asc;

select * from member where mem_name = '블랙핑크';
select * from member where mem_number = 4;

select mem_id, mem_name
	from member
	where height <= 162;

select mem_name, height, mem_number
	from member
	where height >= 165 and mem_number > 6;

select mem_name, height
	from member
	where height >= 163 and height <= 165;
    
select mem_name, height
	from member
    where height between 163 and 165;
    
select mem_name, addr 
	from member
	where addr in('경기', '전남', '경남');
        
select mem_name, addr
	from member
	where addr = '경기' or addr = '전남' or addr = '경남';
        
select mem_name, addr
	from member
	where mem_name like '우%';
        
select mem_id, mem_name, debut_date
	from member
	order by debut_date asc;
	
select mem_id, mem_name, debut_date, height
	from member
	where height >= 164
	order by height desc;
	
select * 
	from member
	limit 3;
	
select * 
	from member
	order by height desc
	limit 3;
	
select mem_name, debut_date
	from member
	order by debut_date
	limit 3;
   
select mem_name, height
From member
order by height desc
limit 3, 2;

select count(distinct addr)
	from member; 
	
select mem_id, amount 
	from buy 
	order by mem_id;
	
select mem_id "회원 아뒤", sum(amount) 
	from buy 
	group by mem_id;
select mem_id "회원 아이디", sum(amount) "총 구매 갯수" 
	from buy 
	group by mem_id;
select mem_id "회원 아이디", sum(price*amount) "총 구매 금액" 
	from buy 
	group by mem_id;
        
select avg(amount) "평균 구매갯수" from buy;

select mem_id, avg(amount) "평균 구매갯수" from buy group by mem_id;

select count(*) from member;
select count(phone1) "연락처가 있는 회원 " from member;

select mem_id "회원아이디", sum(price*amount) "총구메 금액" 
	from buy
	group by mem_id;

select mem_id "회원아이기", sum(price*amount) "총 구매 금액"
	from but
	where sum(price * amount) > 1000
	group by mem_id;

select mem_id "회원아이기", sum(price*amount) "총 구매 금액"
	from buy
	group by mem_id
	having sum(price * amount) > 1000;

create table hongong1 (
	toy_id int, 
	toy_name char(4),
	age int
);

drop table hongong1;

insert into hongong1 values(1, '우디', 25);
insert into hongong1(toy_id, toy_name) values(2, '버즈');
insert into hongong1(toy_name, age, toy_id) values('제시', 20, 3);

select * from hongong1;

drop table hongong2;

create table hongong2(
	toy_id int auto_increment primary key,
	toy_name char(4),
	age int
);

insert into hongong2 values(null, '보핍', 25);
insert into hongong2 values(null, '슬링키', 22);
insert into hongong2 values(null, '렉스', 21);

select last_insert_id();

alter table hongong2 auto_increment = 100;
insert into hongong2 values (null, '재남', 35);
select * from hongong2;

show global variables; 

use world;
select count(*) from city;

select * from city limit 5;

create table city_popul (
	city_name varchar(50),
    population int);
    
insert into city_popul select name, Population from city;

select * from city_popul limit 5;

update city_popul
	set population = population / 10000;
    
delete from city_popul
	where city_name like 'new%';
    
delete from city_popul
	where city_name like 'new%' limit 5;
    
