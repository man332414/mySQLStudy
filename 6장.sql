use market_db;

create table table1 
(
	col1 int primary key,
    col2 int,
    col3 int 
);

show index from table1;

drop table if exists member, buy;
create table member
(
  mem_id char(8),
  mem_name varchar(10),
  mem_number int,
  addr char(2)
);

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울');

-- 자동정렬 클러스터형 인덱스
alter table member
	add constraint
    primary key(mem_id);

select * from member;

show tables;

-- 인덱스 제거 실습
show index from member;

show table status like 'member';

-- 단순보조 인덱스 추가
create index idx_member_addr on member(addr);

-- 인덱스 사용 명령어
analyze table member;

show table status like 'member';

-- 고유보조 인덱스 명령어
create unique index idx_member_mem_number
	on member(mem_number);
    
create unique index idx_member_mem_name
	on member(mem_name);
    
insert into member values('MOO', '마마무', 2, '태국', '001', '12341234', 155, '2020.10.10');

analyze TABLE member;
show index from member;

select * from member;

select * from member
	where mem_name = '에이핑크';
    
-- 인원수 단순보조 인덱스 생성
create index idx_member_mem_number
	on member(mem_number);
analyze table member;

select mem_name, mem_number 
	from member
    where mem_number >= 7;
    
drop index idx_member_mem_number on member;