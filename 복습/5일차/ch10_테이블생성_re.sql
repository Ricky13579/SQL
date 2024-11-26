/*
 * -- DDL(Data Definition Language : 데이터 정의어) : CREATE, ALTER, DROP, TRUNCATE
 *                  => AUTO COMMIT
 * -- DML(Data Manipulation Language : 데이터 조작어) : INSERT, UPDATE, DELETE
 *                  => COMMIT, ROLLBACK
 * -- DQL(Data Query Language : 데이터 질의어) : SELECT
 * -- DCL(Data Control Language : 데이터 제어) : GRANT, REVOKE
 * -- TCL(Transaction Control Language : 트랜잭션 콘트롤 제어) : COMMIT, ROLLBACK
 */
 
-- 테이블 목록 조회
SELECT * from tab;

-- 회원정보 테이블 삭제
DROP table member_tb1_re;

-- 회원정보 테이블 생성
CREATE TABLE member_tb1_re(
    mem_id_re          number(3)       primary key, --PK(Unique, Not Null)
    mem_name_re        varchar2(50)    Not null,    -- 필수
    mem_age_re         number(3),
    mem_email_re       varchar2(60)    unique Not null,      -- 중복 허용 안함
    mem_address_re    varchar2(100)
);

DESC member_tb1_re; -- 테이블구조 확인
SELECT * from member_tb1_re;

INSERT INTO member_tb1_re(mem_id_re, mem_name_re, mem_age_re, mem_email_re, mem_address_re)
 VALUES(101, '손흥민', 30, 'shm@mail.com', '춘천');

INSERT INTO member_tb1_re(mem_id_re, mem_name_re, mem_age_re, mem_email_re, mem_address_re)
 VALUES(102, '호날두', 38, 'cr7@mail.com', '포르투갈');

INSERT INTO member_tb1_re(mem_id_re, mem_name_re, mem_age_re, mem_email_re, mem_address_re)
 VALUES(103, '메시', 38, 'hong@mail.com', '아르헨티나');

INSERT INTO member_tb1_re(mem_id_re, mem_name_re, mem_age_re, mem_email_re, mem_address_re)
 VALUES(104, '노이어', 40, 'manuel@mail.com', '독일');

INSERT INTO member_tb1_re(mem_id_re, mem_name_re, mem_age_re, mem_email_re, mem_address_re)
 VALUES(105, '네이마르', 30, 'jr@mail.com', '브라질');
 
INSERT INTO member_tb1_re(mem_id_re, mem_name_re, mem_age_re, mem_email_re, mem_address_re)
 VALUES(106, '네이마르', 30, 'kkk@mail.com', '서울시 은평구');

commit; -- 영구저장 
rollback; -- 최소기능 => commit 안한 경우 취소가능, commit후에는 rollback
SELECT * from member_tb1_re;

update member_tb1_re
   set mem_name_re = '김덕배', mem_address_re = '벨기에'
 WHERE mem_id_re = 106;

-- 101 : 25세 -> 나이 5씩 증가
update member_tb1_re
   set mem_age_re = 25
 WHERE mem_id_re = 101;

update member_tb1_re
   set mem_age_re = 30
 WHERE mem_id_re = 102;

update member_tb1_re
   set mem_age_re = 35
 WHERE mem_id_re = 103;
 
update member_tb1_re
   set mem_age_re = 40
 WHERE mem_id_re = 104;

update member_tb1_re
   set mem_age_re = 45
 WHERE mem_id_re = 105;
 
commit;
SELECT * from  member_tb1_re;

-- 106번 삭제
DELETE FROM member_tb1_re
 WHERE mem_id_re = 106;

-- SCOTT_04 계정에서 작업
-- 부서테이블(부모테이블) 생성
DROP table DEPT_TBL_re;

CREATE table dept_tbl_re(
--    deptno      number(3)       primary key,    -- 컬럼레벨
    deptno_re      number(3),
    deptname_re    varchar2(50)    not null,
    loc_re         varchar2(50),
    constraint dept_tbl_deptno_re_PK primary key(deptno_re) -- 테이블 레벨
);

SELECT * FROM dept_tbl_re;
DESC dept_tbl_re;

-- 사원테이블(자식테이블) 생성
DROP TABLE emp_tbl_re;
CREATE TABLE emp_tbl_re(
    empno_re       number(3),
    ename_re       varchar2(30) not null,
    hire_date_re   date default sysdate,
    salary_re      number(9) constraint emp_tbl_salary_re_ck_min check(salary_re > 0),
    deptno_re      number(3),  -- FK
    email_re       varchar2(100), -- UNIQUE
    constraint emp_tbl_empno_re_pk primary key(empno_re),
    constraint emp_tbl_deptno_re_fk foreign key(deptno_re) REFERENCES dept_tbl_re(deptno_re)
            ON DELETE CASCADE, -- 자식테이블에 설정하면, 부모테이블 삭제시 자식도 같이 삭제
    constraint emp_tbl_email_re_uk unique(email_re)
);

Insert INTO dept_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(10, 'FW', '오른쪽');

Insert INTO dept_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(20, 'FW', '가운데');

Insert INTO dept_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(30, 'FW', '왼쪽');
 
Insert INTO dept_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(40, 'GK', '뒤쪽');
 
Insert INTO dept_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(50, 'FW', '전부');

commit;

Insert Into emp_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(101, '사카', '2024/01/01', 10000, 10, 'saka@email.com');
 
Insert Into emp_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(102, '케인', '2024/02/01', 20000, 20, 'kane@email.com');
 
Insert Into emp_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(103, '살라', '2024/03/01', 30000, 30, 'salah@email.com');
 
Insert Into emp_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(104, '케파', '2024/04/01', 40000, 40, 'kepa@email.com');
 
Insert Into emp_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(105, '굴리트', '2024/05/01', 50000, 50, 'gullit@email.com');
 
commit;
SELECT * from emp_tbl_re;

Insert INTO dept_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(60, 'MF', '가운데');
 
Insert Into emp_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(106, '캉테', '2024/06/01', 60000, 60, 'kante@email.com');

DELETE FROM dept_tbl_re
 WHERE deptno_re = 60;


SELECT constraint_name
     , constraint_type
     , table_name
  FROM sys.user_constraints   -- 데이터 사전
 WHERE table_name IN('DEPT_TBL_RE', 'EMP_TBL_RE'); -- 테이블 이름은 반드시 대문자

commit;