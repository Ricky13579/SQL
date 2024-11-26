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
DROP table member_tb1;

-- 회원정보 테이블 생성
CREATE TABLE member_tb1(
    mem_id          number(3)       primary key, --PK(Unique, Not Null)
    mem_name        varchar2(50)    Not null,    -- 필수
    mem_age         number(3),
    mem_email       varchar2(60)    unique Not null,      -- 중복 허용 안함
    mem_address     varchar2(100)
);

DESC member_tb1; -- 테이블구조 확인
SELECT * from member_tb1;

/*
 * 테이블에 데이터 추가하기 - 컬럼개수, 컬럼순서, 자료형이 일치해야 한다.
 * INSERT INTO table명(컬럼1, 컬럼2, ..컬럼n)
 * VALUES(값1, 값2, ...값n);
 * - 컬럼명 생략시 테이블 생성시의 모든 컬럼 순서대로 모든 값을 insert해야 한다. 
 * 개수, 자료형 모두 일치해야 하며, 데이터 생략 불가.
 */

INSERT INTO member_tb1(mem_id, mem_name, mem_age, mem_email, mem_address)
 VALUES(101, '김태희', 30, 'kth@mail.com', '서울시 서초구');

INSERT INTO member_tb1(mem_id, mem_name, mem_age, mem_email, mem_address)
 VALUES(102, '비', 35, 'rain@mail.com', '서울시 마포구');

INSERT INTO member_tb1(mem_id, mem_name, mem_age, mem_email, mem_address)
 VALUES(103, '홍길동', 40, 'hong@mail.com', '서울시 금천구');

INSERT INTO member_tb1(mem_id, mem_name, mem_age, mem_email, mem_address)
 VALUES(104, '박나래', 45, 'park@mail.com', '서울시 강남구');

INSERT INTO member_tb1(mem_id, mem_name, mem_age, mem_email, mem_address)
 VALUES(105, '아이유', 30, 'iu@mail.com', '서울시 은평구');
 
INSERT INTO member_tb1(mem_id, mem_name, mem_age, mem_email, mem_address)
 VALUES(106, '아이유', 30, 'kkk@mail.com', '서울시 은평구');

commit; -- 영구저장 
rollback; -- 최소기능 => commit 안한 경우 취소가능, commit후에는 rollback
SELECT * from member_tb1;

/*
 * 데이터 수정
 * UPDATE 테이블명
 *    SET 변경컬럼명1 = 수정데이터1, 변경컬럼명2 = 수정데이터2...
 *  WHERE 조건절
 */
update member_tb1
   set mem_name = '손흥민', mem_address = '런던'
 WHERE mem_id = 106;

-- 101 : 25세 -> 나이 5씩 증가
update member_tb1
   set mem_age = 25
 WHERE mem_id = 101;

update member_tb1
   set mem_age = 30
 WHERE mem_id = 102;

update member_tb1
   set mem_age = 35
 WHERE mem_id = 103;
 
update member_tb1
   set mem_age = 40
 WHERE mem_id = 104;

update member_tb1
   set mem_age = 45
 WHERE mem_id = 105;
 
commit;
SELECT * from  member_tb1;

/*
 * 데이터 삭제
 * DELETE[FROM] 테이블명
 *  WHERE 조건절
 */

-- 106번 삭제
DELETE FROM member_tb1
 WHERE mem_id = 106;

commit;

-----------------------------------
 /* 1. 제약조건(테이블 생성시) => 매우 중요 
 * -- 제약조건이란 테이블에 유효하지 않은(부적절한) 데이터가 입력되는 것을 방지하기 위해서
 *    테이블 생성시 각 컬럼에 대해 정의하는 규칙이다.
 * 
 * -- 데이터 무결성 : 데이터베이스에 저장되는 데이터의 정확성과 일관성을 보장한다는 의미이다.
 *             제약조건은 데이터 무결성을 지키기 위한 안전장치로서 중요한 역할을 한다.
 *             INSERT, UPDATE, DELETE 등 모든 과정에서 제약조건을 지켜야 한다.
 * -- Oracle의 제약조건 종류
 *    구분           설명    
 * - NOT NULL : 컬럼에 NULL 값을 허용하지 않는다. 중복은 허용함
 * - UNIQUE : 지정한 컬럼이 유일한 값을 가져야 한다. 단 null은 값의 중복에서 제외
 * - PRIMARY KEY : 식별자로서 지정한 컬럼이 유일한 값이면서 NULL을 허용하지 않는다. 테이블에 하나만 지정가능하다.
 * - FOREIGN KEY : 부모테이블에 존재하는 PK의 값만 입력가능하다. NULL을 허용한다. 
 * - CHECK : 설정한 조건식을 만족하는 데이터만 입력가능하다.
 * 
 * -- 테이블 생성은 부모테이블부터 하고, 테이블 삭제는 자식테이블부터 한다.
 * -- ON DELETE CASCADE : 자식테이블에 설정하면, 부모테이블 데이터 삭제시, 자식테이블 데이터도 함께 삭제
 */ 

-- SCOTT_04 계정에서 작업
-- 부서테이블(부모테이블) 생성
DROP table DEPT_TBL;

CREATE table dept_tbl(
--    deptno      number(3)       primary key,    -- 컬럼레벨
    deptno      number(3),
    deptname    varchar2(50)    not null,
    loc         varchar2(50),
    constraint dept_tbl_deptno_PK primary key(deptno) -- 테이블 레벨
);

SELECT * FROM dept_tbl;
DESC dept_tbl;

-- 사원테이블(자식테이블) 생성
DROP TABLE emp_tbl;
CREATE TABLE emp_tbl(
    empno       number(3),
    ename       varchar2(30) not null,
    hire_date   date default sysdate,
    salary      number(9) constraint emp_tbl_salary_ck_min check(salary > 0),
    deptno      number(3),  -- FK
    email       varchar2(100), -- UNIQUE
    constraint emp_tbl_empno_pk primary key(empno),
    constraint emp_tbl_deptno_fk foreign key(deptno) REFERENCES dept_tbl(deptno)
            ON DELETE CASCADE, -- 자식테이블에 설정하면, 부모테이블 삭제시 자식도 같이 삭제
    constraint emp_tbl_email_uk unique(email)
);

desc emp_tbl;
SELECT * from emp_tbl;

-- [ dept_tbl ] 10~50 -------------------------
Insert INTO dept_tbl(deptno, deptname, loc)
 VALUES(10, 'IT', '뉴욕');

Insert INTO dept_tbl(deptno, deptname, loc)
 VALUES(20, '마케팅', '캐나다');

Insert INTO dept_tbl(deptno, deptname, loc)
 VALUES(30, '회계', '파리');
 
Insert INTO dept_tbl(deptno, deptname, loc)
 VALUES(40, '인사과', '맨하튼');
 
Insert INTO dept_tbl(deptno, deptname, loc)
 VALUES(50, '경리과', '서울');

commit;

-- [ EMP_TBL ] 101 ~ 105 ----------------
Insert Into emp_tbl(empno, ename, hire_date, salary, deptno, email)
 values(101, '아이유', '2024/01/01', 10000, 10, 'iu@email.com');
 
Insert Into emp_tbl(empno, ename, hire_date, salary, deptno, email)
 values(102, '방탄소년', '2024/02/01', 20000, 20, 'bts@email.com');
 
Insert Into emp_tbl(empno, ename, hire_date, salary, deptno, email)
 values(103, '소지섭', '2024/03/01', 30000, 30, 'cow@email.com');
 
Insert Into emp_tbl(empno, ename, hire_date, salary, deptno, email)
 values(104, '박나래', '2024/04/01', 40000, 40, 'park@email.com');
 
Insert Into emp_tbl(empno, ename, hire_date, salary, deptno, email)
 values(105, '유느님', '2024/05/01', 50000, 50, 'jesus@email.com');
 
commit;
SELECT * from emp_tbl;

-- 부서코드 60 => 오류 : parent key not found
--Insert Into emp_tbl(empno, ename, hire_date, salary, deptno, email)
-- values(106, '유느님', '2024/06/01', 60000, 60, 'test@email.com');

-- dept_tbl, emp_tbl 60번 부서 동시 삭제 가능
-- ON DELETE CASCADE => 이 제약조건이 없으면 부모 삭제시 오류 발생
Insert INTO dept_tbl(deptno, deptname, loc)
 VALUES(60, '메타버스과', '실리콘밸리');
 
Insert Into emp_tbl(empno, ename, hire_date, salary, deptno, email)
 values(106, '테스트', '2024/06/01', 60000, 60, 'test@email.com');

DELETE FROM dept_tbl
 WHERE deptno = 60;

SELECT * from dept_tbl;
SELECT * from emp_tbl;

-- *************************************************
-- 제약조건명 검색 - DBeaver에서 지원안됨
-- 제약조건명은 계정이 동일한 모든 테이블에서 중복되면 안 됨
-- SQL Developer에서 실행
-- *************************************************
SELECT constraint_name
     , constraint_type
     , table_name
  FROM sys.user_constraints   -- 데이터 사전
 WHERE table_name IN('DEPT_TBL', 'EMP_TBL'); -- 테이블 이름은 반드시 대문자

commit;