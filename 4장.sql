-- DB 관리 명령어들
use login_crud;
show tables;
desc member;
select * from member;
drop database test9;


use market_db;

set @myVar1 = 5;
set @myVar2 = 4.25;

select @myVar1;
select @myVar1 + @myVar2;

set @txt = '가수이름 ==>' ;
set @height = 166;

Select @txt , mem_name From member where height > @height;

select * from member;

set @count = 3;
-- select mem_name, height from member order by height limit @count;

prepare mySQL from 'select mem_name, height from member order by height limit ?';
execute mySQL using @count;

select convert(avg(price), signed) '평균가격' from buy;

select cast('2022$12$12' as date);
select cast('2022/12/12' as date);
select cast('2022%12%12' as date);
select cast('2022@12@12' as date);

select num, concat(cast(price as Char), 'X', cast(amount as char), '=') '가격 수량', price*amount '구매액' from buy;

select '100' + '200';

select concat('100', '200');

select concat(100, '200');
select 100 + '200';

select *
	from buy
    inner join member
    on buy.mem_id = member.mem_id;

select *
	from buy
    inner join member
    on buy.mem_id = member.mem_id
    where buy.mem_id = 'GRL';
    
select mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '전화번호'
	from buy
    inner join member
    on buy.mem_id = member.mem_id;
    
select buy.mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '전화번호'
	from buy
    inner join member
    on buy.mem_id = member.mem_id;
    
select buy.mem_id, member.mem_name, buy.prod_name, member.addr, concat(member.phone1, member.phone2) '연락처'
	from buy
    inner join member
    on buy.mem_id = member.mem_id;
    
select b.mem_id, m.mem_name, b.prod_name, m.addr, concat(m.phone1, m.phone2) '연락처'
	from buy b
    inner join member m
    on b.mem_id = m.mem_id;
    
select m.mem_id, m.mem_name, b.prod_name, m.addr
	from member m
    left outer join buy b
    on m.mem_id = b.mem_id;
    
select m.mem_id, m.mem_name, b.prod_name, m.addr
	from buy b
    right outer join member m
    on m.mem_id = b.mem_id;
    
select * 
	from member
    inner join buy
    on buy.mem_id = member.mem_id;
    
select *
	from buy b
    right outer join member m
    on m.mem_id = b.mem_id;
    
select *
	from member m
    right outer join buy b
    on m.mem_id = b.mem_id;
    
use market_db;

create table emp_table(
	emp char(4),
    manager char(4),
    phone varchar(8)
    );
    
insert into emp_table values('대표', null, '0000');
insert into emp_table values('영업이사', '대표', '1111');
insert into emp_table values('관리이사', '대표', '2222');
insert into emp_table values('정보이사', '대표', '3333');
insert into emp_table values('영업과장', '영업이사', '1111-1');
insert into emp_table values('경리부장', '관리이사', '2222-1');
insert into emp_table values('인사부장', '관리이사', '2222-2');
insert into emp_table values('개발팀장', '정보이사', '3333-1');
insert into emp_table values('개발주임', '정보이사', '3333-2');

select * from emp_table;

select a.emp '직원', a.manager '직속상관', b.phone '직속상관전화번호' 
	from emp_table a
    inner join emp_table b
		on a.manager = b.emp
    where a.emp = '경리부장';
    
delimiter $$
create procedure ifpro3()
begin
	declare debutDate date;
    declare curDate date;
    declare days int;
    
    select debut_date into debutDate
    from member
    where mem_id = 'APN';
    
    set curDate = current_date();
    set days = datediff(curDate, debutDate);
    
    if(days/365) >= 5 then
			select concat('데뷔한 지 ', days, '일이나 지났습니다. 축하합니다.');
        else
			select '데뷔한 지 ' + days + '일이 되었습니다. 화이팅 입니다.'; 
        end if;
	end$$
delimiter ;
call ifpro3();

-- 1단계 : 셀렉문 작성
select mem_id, sum(price*amount) '총구매액'
	from buy
    group by mem_id;

-- 2단계 : 정렬
select mem_id, sum(price*amount) '총구매액'
	from buy
    group by mem_id
    order by sum(price*amount) DESC;
    
-- 3단계 : member테이블과 내부 조인 하여 멤버 아이디 옆에 멤버 네임 출력 buy 테이블에 없는 데이터는 출력되지 않음
select b.mem_id, m.mem_name, sum(price*amount) '총구매액'
	from buy b
		inner join member m
		on b.mem_id = m.mem_id
    group by b.mem_id
    order by sum(price*amount) DESC;
    
-- 4단계 : member 테이블과 외부조인하여 buy 테이블에 없는 member mem_id들도 출력
select m.mem_id, m.mem_name, sum(price*amount) '총구매액'
	from buy b
		right outer join member m
		on b.mem_id = m.mem_id
    group by m.mem_id
    order by sum(price*amount) DESC;
    
-- 5단계 : case 문 사용하여 구매액에 따른 고객 등급분류
case
	when (총구매액>=1500) then '최우수고객'
	when (총구매액>=1000) then '우수고객'
    when (총구매액>=500) then '일반고객'
    else '유령고객'
end;

-- 6단계 : case문을 원래 쿼리와 합치기
select m.mem_id, m.mem_name, sum(price*amount) '총구매액', 
		case
			when (sum(price*amount)>=1500) then '최우수고객'
			when (sum(price*amount)>=1000) then '우수고객'
			when (sum(price*amount)>=1) then '일반고객'
			else '유령고객'
		end '회원등급'
	from buy b
		right outer join member m
		on b.mem_id = m.mem_id
    group by m.mem_id
    order by sum(price*amount) DESC;
    
drop procedure ifpro3;

drop procedure if exists whileproc;

delimiter $$
create procedure whileproc()
begin
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    while(i<=100) do
		set hap = hap + i;
        set i = i + 1;
	end while;
    select '1부터 100까지의 정수 합 ==> ', hap;
end $$
delimiter ;
call whileproc();

drop procedure if exists whileproc2;
delimiter $$
create procedure whileproc2()
begin
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    myWhile:
    while(i<=100)do
		if(i%4 = 0) then
			set i = i + 1;
            iterate myWhile;
		end if;
		set hap = hap + i;
        if(hap > 1000) then
			leave myWhile;
		end if;
        set i = i + 1;
	end while;
    
    select '1부터 100까지의 합(4의 배수 제외), 1000을 넘으면 종료 ==> ', hap;
end $$
delimiter ;
call whileproc2();

drop table if exists gate_table;
create table gete_table(id int auto_increment primary Key, entry_time datetime);

create table 고객
(
	고객아이디 varchar(20) primary key,
    고객이름 varchar(20) not null,
    나이 int,
    등급 varchar(20) not null,
    직업 varchar(20) ,
    적립금 int default 0
);

desc 고객;

create table 제품
(
	제품번호 char(3) primary key,
    제품명 varchar(30),
    재고량 int ,
    단가 int,
    제조업체 varchar(20),
    check(재고량 >= 0 and 재고량 <= 10000)
);

desc 제품;

create table 주문
(
	주문번호 char(3) primary key,
    주문고객 varchar(20),
    주문제품 varchar(30),
    수량 int,
    배송지 varchar(30),
    주문일자 date,
    foreign key(주문고객) references 고객(고객아이디),
	foreign key(주문제품) references 제품(제품번호)
);

desc 주문;

create table 배송업체
(
	업체번호 varchar(10) primary key,
    업체명 varchar(20),
    주소 varchar(30),
    전화번호 char(12)
);

desc 배송업체;

show tables;
drop tables 고객, 배송업체, 제품, 주문;
use market_db;

alter table 고객
	add 가입날짜 date;
desc 고객;

alter table 고객
	drop column 가입날짜;
desc 고객;

alter table 고객 add constraint checkAge check(나이 >= 20);
desc 고객;

alter table 고객 drop constraint checkAge;
desc 고객;

















































