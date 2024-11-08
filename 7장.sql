use market_db;
drop procedure if exists user_proc;
delimiter $$
create procedure user_proc()
begin
	select * from member;
end $$
delimiter ;

call user_proc();

drop procedure user_proc;

-- 입력 매게변수
use market_db;
drop procedure if exists user_proc1;
delimiter $$
create procedure user_proc1(in userName varchar(10))
begin
	select * from member where mem_name = userName;
end $$
delimiter ;

call user_proc1('에이핑크');

-- 출력 매개변수
use market_db;
drop procedure if exists user_proc3;
delimiter $$
create procedure user_proc3(
	in txtValue char(10),
    out outValue int
    )
begin
	insert into noTable values(null, txtValue);
	select max(id) into outValue from noTable;
end $$
delimiter ;

create table if not exists noTable
(
	id int auto_increment primary key,
    txt char(10)
);

call user_proc3('테스트1', @myValue);
select concat('입력된 ID 값 ==> ', @myValue);

-- sql 프로그래밍 활용

drop procedure if exists ifelse_proc;
delimiter $$
create procedure ifelse_proc(in memName varchar(10))
begin
	declare debutYear int;
    select year(debut_date) into debutYear from member
		where mem_name = memName;
    if(debutYear >= 2015) then
		select '신인가수네요, 화이팅 하세요.' as '메세지';
	else
		select '고참 가수네요, 그동안 고생많았어요.' as '메세지';
	end if;
end $$
delimiter ;

call ifelse_proc('오마이걸');

set global log_bin_trust_function_creators = 1;

use market_db;
drop function if exists sumFunc;
delimiter $$
create function sumFunc(num1 int, num2 int)
	returns int
begin
	return num1 + num2;
end $$
delimiter ;

select sumFunc(100, 200) as '합계';

-- 데뷔년도에 따른 활동기간 반환 함수 제작

delimiter $$
create function calcyearfunc(dyear int)
	returns int
begin
	declare runyear int;
    set runyear = year(curdate()) - dyear;
    return runyear;
end $$
delimiter ;

select calcyearfunc(2010) as '활동 햇수';

select calcyearfunc(2007) into @debut2007;
select calcyearfunc(2013) into @debut2013;
select @debut2007-@debut2013 as '2007과 2013차이';

select mem_id, mem_name, calcyearfunc(year(debut_date)) as '활동 햇수' from member;

drop function calcyearfunc;

show create function calcyearfunc;

-- 커서와 관련된 코드 
use market_db;
drop procedure if exists cursor_proc;
delimiter $$
create procedure cursor_proc()
begin
	declare memNumber int;
    declare cnt int default 0;
    declare totNumber int default 0;
    declare endofRow boolean default false;
	
    declare memberCursor cursor for
		select mem_number from member;
	
    declare continue handler for 
		not found set endofRow = true;
	
	open memberCursor;
		
	cursor_loop : loop
		fetch memberCursor into memNumber;
		
		if endOfRow then
			leave cursor_loop;
		end if;
    
		set cnt = cnt + 1;
		set totNumber = totNumber = memNumber;
	end Loop cursor_loop;


select(totNumber/cnt) as '회원의 평균 인원 수';

close memberCursor;

end $$
delimiter ;

call cursor_proc();




