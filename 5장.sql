-- 테이블 설계하기 p217
create database naver_db;

use naver_db;

create table member
(
	id varchar(30) primary key,
    name varchar(20),
    no int,
    addr varchar(50),
    tel1 char(3),
    tel2 char(8),
    height int,
    debute date
);

desc member;

alter table member change dbut debute date;

create table buy
(
	num int auto_increment primary key,
    id varchar(30),
    product varchar(50),
    category varchar(20),
    price int,
    amount int,
    foreign key(id) references member(id)
);

desc member;

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

select * from member;
select * from buy;

-- create에서 설정하는 기본키 제약조건 p237
use naver_db;

drop table if exists buy, member;

create table member
(
	mem_id char(8) primary key,
    mem_name varchar(10) not null,
    height tinyInt unsigned null
);

-- create 구문 마지막에 추가하는 기본키 조건
drop table if exists member;

create table member
(
	mem_id char(8),
    mem_name varchar(10) not null,
    height tinyInt unsigned null,
    primary key(mem_id)
);

-- alter로 추가하는 기본키 제약조건 p238
drop table if exists member;

create table member
(
	mem_id char(8),
    mem_name varchar(10) not null,
    height tinyInt unsigned null
);

alter table member add constraint primary key(mem_id);

drop table if exists member;

create table member
(
	mem_id char(8),
    mem_name varchar(10) not null,
    height tinyInt unsigned null,
    primary key PK_member_mem_id (mem_id)
);


drop table if exists buy, member;

create table member
(
	mem_id char(8) primary key,
    mem_name varchar(10) not null,
    height tinyInt unsigned null
);

create table buy
(
	num int auto_increment primary key,
    mem_id char(8) not null,
    prod_name char(6) not null,
    foreign key(mem_id) references member(mem_id)
);

drop table if exists buy, member;

create table member
(
	mem_id char(8) primary key,
    mem_name varchar(10) not null,
    height tinyInt unsigned null
);

create table buy
(
	num int auto_increment primary key,
    user_id char(8) not null,
    prod_name char(6) not null,
    foreign key(user_id) references member(mem_id)
);

drop table if exists buy;
create table buy
(
	num int auto_increment primary key,
    user_id char(8) not null,
    prod_name char(6) not null,
    foreign key(user_id) references member(mem_id)
);

insert into member values('BLK', '블랙핑크', 163);
insert into buy values(NULL, 'BLK', '지갑');
insert into buy values(NULL, 'BLK', '맥북');

desc member;

select m.mem_id, m.mem_name, b.prod_name
	from buy b
		inner join member m
        on b.mem_id = m.mem_id;

update member set mem_id = 'PINK'  where mem_id = 'BLK';
delete from member where mem_id = 'BLK';

drop table if exists buy;
create table buy
(
	num int auto_increment primary key,
    mem_id char(8) not null,
    prod_name char(6) not null
);

alter table buy
	add constraint
    foreign key(mem_id) references member(mem_id)
    on update cascade
    on delete cascade;

desc buy;

insert into buy values(NULL, 'BLK', '지갑');
insert into buy values(NULL, 'BLK', '맥북');

update member set mem_id = 'PINK'  where mem_id = 'BLK';

select m.mem_id, m.mem_name, b.prod_name
	from buy b
		inner join member m
        on b.mem_id = m.mem_id;

delete from member where mem_id = 'PINK';

Select * from buy;

-- 고유키 제약조건
drop table if exists buy, member;

create table member
(
	mem_id char(8) primary key,
    mem_name varchar(10) not null,
    height tinyInt unsigned null,
    email char(30) null unique
);

insert into member values('BLK', '블랙핑크', 163, 'pink@gmail.com');
insert into member values('TWC', '트와이스', 167, null);
insert into member values('APN', '에이핑크', 164, 'pink@gmail.com');

-- 체크 제약조건

drop table if exists member;
create table member
(
	mem_id char(8) not null primary key,
    mem_name varchar(30) not null,
    height tinyint unsigned null check(height >= 100),
    phone1 char(3) null
);

insert into member values('BLK', '블랙핑크', 163, null);
insert into member values('TWC', '트와이스', 99, null);

select * from member;

-- alter을 통한 제약조건 추가
alter table member
	add constraint
    check (phone1 in ('02', '031', '032', '054', '055', '061'));
    
-- 데이터 입력 오류 검사
insert into member values('TWC', '트와이스', 167, '02');
insert into member values('OMY', '오마이걸', 167, '010');

-- 기본값 정의

drop table if exists member;
create table member
(
	mem_id char(8) not null primary key,
    mem_name varchar(10) not null,
    height tinyint unsigned null default 160,
    phone1 char(3) null
);

-- alter 를 이용한 기본값 제약사항 추가
alter table member
	alter column phone1 set default '02';

-- 값 입력
insert into member values ('RED', '레드벨벳', 161, '054');
insert into member values ('SPC', '우주소녀', default, default);
insert into member values ('null', 'null', null, null);
select * from member;

-- 5-3 뷰 p254
DROP DATABASE IF EXISTS market_db; -- 만약 market_db가 존재하면 우선 삭제한다.
CREATE DATABASE market_db;

USE market_db;
CREATE TABLE member -- 회원 테이블
( mem_id  		CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  mem_name    	VARCHAR(10) NOT NULL, -- 이름
  mem_number    INT NOT NULL,  -- 인원수
  addr	  		CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  phone1		CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2		CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 평균 키
  debut_date	DATE  -- 데뷔 일자
);
CREATE TABLE buy -- 구매 테이블
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   mem_id  	CHAR(8) NOT NULL, -- 아이디(FK)
   prod_name 	CHAR(6) NOT NULL, --  제품이름
   group_name 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 가격
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

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

use market_db;
create view v_member
as select mem_id, mem_name, addr from member;

select * from v_member;

-- 뷰 선택 p258
select mem_name, addr from v_member
	where addr in('서울', '경기');
    
-- 복잡한 sql 단순하게 하기
select b.mem_id, m.mem_name, b.prod_name, m.addr, concat(m.phone1, m.phone2) '연락처'
	from buy b
		inner join member m
        on b.mem_id = m.mem_id;
        
create view v_memberbuy
as select b.mem_id, m.mem_name, b.prod_name, m.addr, concat(m.phone1, m.phone2) '연락처'
	from buy b
		inner join member m
        on b.mem_id = m.mem_id;

select * from v_memberbuy;

-- 뷰의 컬럼을 다른이름으로 설정하기
select b.mem_id 'Member ID', m.mem_name as 'Member Name', b.prod_name "Product Name", concat(m.phone1, m.phone2) as "Office Phone"
	from buy b
    inner join member m
    on b.mem_id = m.mem_id;
    
create view v_viewtest1
as select b.mem_id 'Member ID', m.mem_name as 'Member Name', b.prod_name "Product Name", concat(m.phone1, m.phone2) as "Office Phone"
	from buy b
    inner join member m
    on b.mem_id = m.mem_id;
    
select distinct `Member ID`, `Member Name` from v_viewtest1;

-- 뷰의 컬럼을 한글로 설정하기 권장하지 않음 
create view v_viewtest2
as select b.mem_id '회원 아이디', m.mem_name as '회원 이름', b.prod_name "제품이름", concat(m.phone1, m.phone2) as "연락처"
	from buy b
    inner join member m
    on b.mem_id = m.mem_id;

select distinct `회원 아이디`, `회원 이름` from v_viewtest2;

-- 뷰를 통한 데이터의 수정 / 삭제
use market_db;

update v_member set addr = '부산' where mem_id = 'BLK';

select * from v_member;

desc v_member;

-- 지정한 범위로 뷰 생성
select * from member where height >= 167;

create view v_height167
as select * from member where height >= 167;

select * from v_height167;

-- 삭제
delete from v_height167 where height < 167;

-- 뷰의 where절 범위에 벗어나는 데이터 입력
insert into v_height167 values('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-01-01');

SELECT * FROM v_height167;
SELECT * FROM member;

-- 뷰에 with check option 적용하기
alter view v_height167
as select * from member where height >= 167
with check option;

insert into v_height167 values('TOB', '텔레토비', 4, '영국', null, null, 140, '1995-01-01');