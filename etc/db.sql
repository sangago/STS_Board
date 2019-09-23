/* password 변경 */
ALTER USER 'gosang'@'localhost' IDENTIFIED WITH mysql_native_password BY 'a1b2c3^^';



/* 테이블생성 */
CREATE TABLE sequence_table(
	seq int auto_increment primary key,
    bno int(10),
    title varchar(200) not null,
    content varchar(2000) not null,
    wirter varchar(50) not null,
    regdate datetime not null default current_timestamp,
    updatedate datetime not null default current_timestamp
);

/* 테이블 삭제 */
drop table tbl_board;


/* 테이블명 변경하기 */
RENAME TABLE sequence_table TO tbl_board;

/* 컬럼명변경 */
alter table tbl_board change wirter writer varchar(50);
/* 컬럼 삭제 */
ALTER TABLE tbl_board drop seq;

/* 제약조건 삭제 */
ALTER TABLE tbl_board DROP primary key;

/* 제약조건(이름부여) */
ALTER TABLE tbl_board add constraint pk_board primary key(bno);

/* 컬럼 속성 변경 */
ALTER TABLE tbl_board modify bno int(10) auto_increment;

/* 테이블 정보조회 */
SHOW TABLE STATUS;

/* 컬럼정보조회 */
SHOW FULL COLUMNS FROM tbl_board;

/* 기본키 삭제 (auto_increment속성이 있을경우 삭제가 안됨) */
ALTER TABLE tbl_board DROP primary key;

/* auto_increment 삭제 */
alter table tbl_board modify column bno int(10);

/* auto_increment 시작값 설정 */
alter table tbl_board auto_increment=1;


/* 더미데이터 추가 */
insert into tbl_board(title, content, writer)
values ('테스트제목38849', '테스트내용', 'user00');

/* 테이블 조회 */
select * from tbl_board;


/* 시퀀스 테이블 생성 */
CREATE TABLE seq_board ( name varchar(32), currval BIGINT UNSIGNED ) ENGINE=InnoDB;



/* 시퀀스 프로시저 생성 
DELIMITER $$

CREATE PROCEDURE `create_sequence`(IN the_name text)

MODIFIES SQL DATA

DETERMINISTIC

BEGIN

    DELETE FROM seq_board WHERE name = the_name;

    INSERT INTO seq_board VALUES (the_name, 0);

END;



DELIMITER $$

CREATE PROCEDURE  `drop_sequence`(IN the_name text)

MODIFIES SQL DATA 

DETERMINISTIC

BEGIN

	DELETE FROM seq_board WHERE name = the_name; 
    
END;

SET Global log_bin_trust_function_creators='ON';

/* currval, nextval 
DELIMITER $$

CREATE FUNCTION `currval`(the_name varchar(32))

RETURNS BIGINT UNSIGNED

READS SQL DATA

DETERMINISTIC

BEGIN

	DECLARE ret BIGINT UNSIGNED;

	SELECT currval INTO ret FROM seq_board WHERE name = the_name limit 1;

	RETURN ret; 

END;


DELIMITER $$

CREATE FUNCTION `nextval`(the_name varchar(32))

RETURNS BIGINT UNSIGNED

READS SQL DATA

DETERMINISTIC

BEGIN

	DECLARE ret BIGINT UNSIGNED;

	UPDATE seq_board SET currval=currval + 1 WHERE name = the_name;

	SELECT currval INTO ret FROM seq_board WHERE name = the_name limit 1;

	RETURN ret; 

END;
*/


/* 재귀 복사를 이용해 더미데이터 생성 */
insert into tbl_board(title, content, writer)
(select title, content, writer from tbl_board);

SELECT COUNT(*) from tbl_board;

select * from tbl_board;

/* 정렬하여 보기 */
select * from tbl_board order by bno desc;

/* 인코딩셋 보기 */
show variables like '%c';


DROP FUNCTION nextval;
DROP FUNCTION currval;

DROP PROCEDURE drop_sequence;


/* 제약조건 조회하기 */
SELECT * FROM information_schema.table_constraints;

/* primary key에 제약조건명을 부여 하지 않아서 다시 primary key 설정을 해야 했음
그러기 위해서는 먼저 auto_increment를 먼저 해제한 후 키본키를 해제하고 다시 제약조건명을 쓴 primary key를 설정하고
다시  auto_increment를 설정해줘야 함 */

/* auto_increment 해제 */
alter table tbl_board modify bno int;

/* 키본키 해제 */
alter table tbl_board drop primary key;

/* 기본키 제약조건 설정 */
alter table tbl_board add constraint pk_board primary key (bno);

/* auto_increment 설정 */
alter table tbl_board modify bno int auto_increment;


select * from tbl_board order by bno desc;


set @rownum:=0;
select @rownum:=@rownum+1 as rn, dic.*
from tbl_board dic
where(@rownum:=0)=0;



select @rownum bno, title, content from tbl_board;


select /* +INDEX_DESC(tbl_board pk_board */
	@rownum bno, title, content
from 
	tbl_board
where 
	@rownum <= 20;
    
select * from tbl_board where bno > 0 order by bno desc limit 0, 10;

delete from tbl_board where bno>50000;

select * from tbl_board where bno > 0 (title like '%modal%');


/* 댓글 테이블 */
create table tbl_reply (
	rno int(10),
    bno int(10) not null,
    reply varchar(1000) not null,
    replyer varchar(50) not null,
    replyDate datetime not null default current_timestamp,
    updateDate datetime not null default current_timestamp
    );
 
 /* rno 기본키 설정 */
 alter table tbl_reply add constraint pk_reply primary key(rno);
 
 /* auto_increment 설정 */
alter table tbl_reply modify rno int auto_increment;
 
/* auto_increment 시작값 설정 */
alter table tbl_reply auto_increment=1;

/* 외래키 설정 */
alter table tbl_reply add constraint fk_reply_board foreign key (bno) references tbl_board (bno);

select * from tbl_board where bno < 10 order by bno desc;

select * from tbl_reply order by rno desc;

select * from tbl_board where bno < 320 order by bno desc;

select * from tbl_reply where bno=314 order by rno desc;

insert into rno_board(reply, replyer) values ('테스트제목', '테스트내용') where bno=1tbl_reply;

/* 인덱스 생성 */
create index idx_reply on tbl_reply (bno desc, rno asc);

/* 조회 */
select bno, rno, reply, replyer, replyDate, updatedate
from tbl_reply
where bno = 1
and rno > 0;

insert into tbl_reply(reply, replyer) values('test','tester00');

create table tbl_sample1( col1 varchar(500));
create table tbl_sample2( col2 varchar(50));

-- 댓글 (tbl_board에 replycnt 칼럼 추가  
alter table tbl_board add (replycnt int default 0);

update tbl_board set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);

SET SQL_SAFE_UPDATES = 0;	-- error 1175 해결위해 사용 

select * from tbl_board where bno order by desc;

/* 첨부파일 테이블 만들기 */
create table tbl_attach(
	uuid varchar(100) not null,
    uploadPath varchar(200) not null,
    fileName varchar(100) not null,
    filetype char(1) default 'I',
    bno int(10)
);

/* 제약조건 */
alter table tbl_attach add constraint pk_attach primary key(uuid);

alter table tbl_attach add constraint fk_board_attach foreign key(bno) references tbl_board(bno);

select * from tbl_attach;

select * from tbl_attach where uploadpath = date_format(now()-1, 'yyyy/mm/dd');



/* 스프링 시큐리티의 지정된 테이블을 생성 */
create table users(
	username varchar(50) not null primary key,
    password varchar(50) not null,
    enabled char(1) default '1' );
    
create table authorities (
	username varchar(50) not null,
    authority varchar(50) not null,
    constraint fk_authorities_users foreign key(username) references users(username)
);

select * from users;
create unique index ix_auth_username on authorities (username, authority);

insert into users (username, password) values ('user00','pw00');
insert into users (username, password) values ('member00','pw00');
insert into users (username, password) values ('admin00','pw00');

insert into authorities (username, authority) values('user00', 'ROLE_USER');
insert into authorities (username, authority) values('member00', 'ROLE_MANAGER');
insert into authorities (username, authority) values('admin00', 'ROLE_MANAGER');
insert into authorities (username, authority) values('admin00', 'ROLE_ADMIN');
commit;



create table tbl_member(
	userid varchar(50) not null primary key,
    userpw varchar(100) not null,
    username varchar(100) not null,
    regdate datetime not null default current_timestamp,
    updatedate datetime not null default current_timestamp,
    enabled char(1) default '1'
);

create table tbl_member_auth(
	userid varchar(50) not null,
    auth varchar(50) not null,
    constraint fk_member_auth foreign key(userid) references tbl_member(userid)
);

select * from tbl_member where userid like "%test%";

create table persistent_logins(
	username varchar(64) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used timestamp not null
);

select * from persistent_logins;

alter table tbl_member add(userbno integer(10));

/* 기본키 제약조건 설정 */
alter table tbl_member add constraint uni_member UNIQUE (userbno);

/* auto_increment 설정 */
alter table tbl_member modify userbno int auto_increment;

/* auto_increment 시작값 설정 */
alter table tbl_member auto_increment=23;

select * from tbl_member order by regdate desc;

repair table tbl_member;

alter table tbl_member drop userbno;

select * from tbl_member_auth;

DELIMITER $$
create trigger TRG_signup_auth
after insert on tbl_member
for each row begin
	insert into tbl_member_auth(userid, auth) values (new.id, ROLE_USER)
end;
DELIMITER $$













