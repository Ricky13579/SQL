/*  1.트랜잭션 / 2.데이터사전 / 3.인덱스 / 4.시퀀스
 [ 1. 트랜잭션 ]
- 트랜잭션은 데이터 처리에서 논리적인 하나의 작업 단위를 의미한다.
- ALL or Nothing : 여러개의 명령어 집합이 정상적으로 처리되면 정상종료하고,
                            명령어들중 하나라도 잘못된다면 전체를 취소한다.
- DML 작업이 성공적으로 처리되었다면 COMMIT을, 
         취소해야 한다면 ROLLBACK 명령을 실행한다.
         ROLLBACK : COMMIT 후에 취소가 되지 않는다.
         
- DDL(테이블생성, 수정), DCL(권한)문이 실행되는 경우에는 자동으로 COMMIT 된다. COMMIT 할 필요 없다.
- COMMIT - 트랜잭션의 처리과정을 반영하여 변경된 내용을 영구저장한다. 모든 작업들의 정상처리확정 명령어다.
           INSERT, UPDATE, DELETE(즉 DML) 후 COMMIT을 해야 한다. 
           
- LOCK : 특정 세션에서 조작중인 데이터는 트랜잭션이 완료(COMMIT, ROLLBACK)되기 전까지 다른 계정에서 
         조작할 수 없도록 접근을 보류시키게 된다. 즉 데이터가 '잠금현상'이 일어난다.
         트랜잭션이 완료(COMMIT, ROLLBACK)가 되면 LOCK이 풀리게 된다.
         
         주의 : WHERE절을 지정하지 않은 UPDATE, DELETE문일 경우에는 테이블의 모든행이 LOCK 상태가 된다.
           
- DBeaver 툴에서는 savepoint가 작동안됨           
- SAVEPOINT - 현재의 트랜잭션을 작게 분할한다. 대소문자 구별함
   저장된 SAVEPOINT는 ROLLBACk TO SAVEPOINT 문을 사용하여 표시한 곳까지 롤백할 수 있다.
  1) SAVEPOINT S1;   -- S1 : SAVEPOINT명
     SAVEPOINT S2;   -- S2 : SAVEPOINT명0
  2) ROLLBACk TO S1;   -- S1 : SAVEPOINT명
*/ 

-- 구조 + 데이터
CREATE TABLE member_tb1_tr
    AS SELECT * FROM member_tb1;
SELECT * FROM member_tb1_tr;

-- 1. 103번 이메일수정
UPDATE member_tb1_tr
   SET mem_email = 'hongkildong@naver.com'
 WHERE mem_id = 103;
 
SAVEPOINT s1;

-- 2. 101번 삭제
DELETE FROM member_tb1_tr
 WHERE mem_id = 101;

SAVEPOINT s2;


-- 3. 102번 삭제
DELETE FROM member_tb1_tr
 WHERE mem_id = 102;

SAVEPOINT s3;

-- 4. 104번 삭제
DELETE FROM member_tb1_tr
 WHERE mem_id = 104;
 
SAVEPOINT s4;

-- 순서대로 실행
rollback to s3; -- 104번 부활
rollback to s2; -- 102번 부활
rollback to s1; -- 101번 부활
rollback;       -- COMMIT 이후 시점 (103번 이메일이 원래대로 복귀)
SELECT * from member_tb1_tr;

/* SQL DEVELOPER에서 실행
 * [ 2. 데이터 사전 ]
 * - 데이터 사전 : 사용자와 데이터베이스 자원의 효율적 관리를 위한 다양한 정보를 저장하는 시스템 테이블의 집합이다.
 * - 사용자가 테이블을 생성하거나, 사용자를 변경하는 등의 작업을 할 때 데이터베이스 서버에 의해
 *   자동으로 갱신되는 테이블이다.
 
 * - [접두어]
 * USER_XXXX : 자신의 계정이 소유한 객체 등에 관한 정보조회
 * ALL_XXXX : 사용허가를 받은 모든 객체 정보 조회
 * DBA_XXXX : 데이터베이스 관리자(SYSTEM, SYS)만 접근가능한 정보
 * 
 * - 데이터 사전 - USER_데이터사전
 *   . USER_SEQUENCES : 사용자가 소유한 시퀀스의 정보
 *   . USER_INDEXES : 사용자가 소유한 인덱스의 정보
 *   . USER_VIEWS : 사용자가 소유한 뷰의 정보
 *   . USER_TABLES : 사용자가 소유한 테이블의 정보
 */
-- SCOTT_04 계정에서 실행
-- user_tables : USER_데이터 사전 => 자신의 계정에서 개인이 만든 테이블 목록 조회
-- 테이블 목록
SELECT table_name
  FROM user_tables;

-- 뷰 목록
SELECT view_name
  FROM user_views;

-- all 접두어를 가진 데이터 사전
SELECT owner, table_name
  FROM all_tables;

-- system 계정에서 실행
-- DBA 접두어를 가진 데이터 사전
SELECT owner, table_name
  FROM dba_tables;

-- system 계정에서 실행
SELECT *
  FROM dba_users
 WHERE username = 'SCOTT_04';   -- 계정이름은 대문자
-- SCOTT_04	 48		OPEN		25/05/18	USERS	TEMP	24/11/19	DEFAULT	DEFAULT_CONSUMER_GROUP		10G 11G 	N	PASSWORD

/* [ 3. 인덱스 ]    
    인덱스의 종류
 - 1)비고유 인덱스 : 중복된 데이터를 갖는 컬럼에 대해서 생성하는 인덱스이며, UNIQUE를 붙이면 에러 발생
 - 2)고유 인덱스 : 기본키나 유일키처럼 유일한 값을 갖는 컬럼에 대해서 생성하는 인덱스이며, UNIQUE INDEX로 사용한다.
 - 3)결합 인덱스 : 두개 이상의 컬럼으로 인덱스를 구성
 - 4)함수기반 인덱스 : 수식이나 함수를 적용하여 만든 인덱스
*/ 
-- 구조, 데이터까지 복사(단 제약조건은 복사안됨)
-- scott_04 계정에서
CREATE TABLE emp_idx_tbl
AS
SELECT * FROM emp_tbl;

CREATE TABLE dept_idx_tbl
AS
SELECT * FROM dept_tbl;

SELECT * FROM emp_tbl;
SELECT * FROM dept_tbl;

-- 1) 인덱스 : 비고유
-- 중복된 데이터를 갖는 컬럼에 대해서 생성하는 인덱스이며, UNIQUE를 붙이면 에러 발생
-- 서브쿼리로 테이블 생성시 제약조건이 복사가 안되므로 에러가 발생하지 않는다.
DROP INDEX idx_emp_ename;
CREATE INDEX idx_emp_ename  
    ON emp_idx_tbl(ename);  -- ON 테이블명(컬럼)

-- 인덱스 생성 확인
SELECT index_name
     , table_name
     , column_name
  FROM USER_IND_COLUMNS
 WHERE table_name = 'EMP_IDX_TBL'; -- 테이블명은 반드시 대문자


-- 2) 고유 인덱스:
-- 기본기나 유일키처럼 유일한 값을 갖는 컬럼에 대해서 생성하는 인덱스이며, UNIQUE INDEX로 사용한다.
DROP INDEX idx_dept_deptno;
CREATE UNIQUE INDEX idx_dept_deptno
    ON dept_idx_tbl(deptno);

-- 인덱스 생성 확인
SELECT index_name
     , table_name
     , column_name
  FROM USER_IND_COLUMNS
 WHERE table_name = 'DEPT_IDX_TBL';

-- 3) 결합 인덱스 : 두 개 이상의 컬럼으로 인덱스를 구성
DROP INDEX idx_dept_com;
CREATE INDEX idx_dept_com
    ON dept_idx_tbl(deptname, loc);

SELECT index_name
     , table_name
     , column_name
  FROM USER_IND_COLUMNS
 WHERE table_name = 'DEPT_IDX_TBL';

-- 4) 함수기반 인덱스 : 수식이나 함수를 적용하여 만든 인덱스
DROP INDEX idx_emp_salary;
CREATE INDEX idx_emp_salary
    ON emp_idx_tbl(salary * 12);

SELECT index_name
     , table_name
     , column_name
  FROM USER_IND_COLUMNS
 WHERE table_name = 'EMP_IDX_TBL';

/*
   [ 4. 시퀀스 ]  
    시퀀스는 테이블내의 유일한 숫자를 자동으로 생성해주며, 기본키로 사용된다.
   새로운 데이터가 추가될 때 기본키값을 자동으로 발생시키는 용도로 사용된다.
   마치 mysql의 auto_increment와 동일
   
   CURRVAL : 시퀀스에서 마지막으로 생성한 번호를 반환
             - 시퀀스를 생성하고 바로 사용하면 번호가 만들어진적이 없으므로 오류가 발생 => 처음 시퀀스를 만든 경우 NEXTVAL을 먼저 조회해야 한다.)
   NEXTVAL : 다음 번호를 생성
      
   사용 : 게시판의 게시글번호, 상품주문번호
   -- [형식]
   -- 시퀀스 생성
   CREATE SEQUENCE 시퀀스명
     START WITH n
     INCREMENT BY n
     MAXVALUE n | MINVALUE n
     CYCLE | NOCYCLE
     CACHE | NOCACHE
     
   -- 생성한 시퀀스 확인(데이터사전)
   SELECT *
     FROM USER_SEQUENCES;
     
   -- 시퀀스 삭제  
   DROP SEQUENCE 시퀀스명;  
*/

DROP SEQUENCE dept_seq;
CREATE SEQUENCE dept_seq
    START WITH 10
    INCREMENT BY 10
    MAXVALUE 90
    MINVALUE 0
    NOCYCLE;

-- 생성한 시퀀스 확인(데이터사전)
SELECT *
  FROM USER_SEQUENCES;

-- CURRVAL : 시퀀스에서 마지막으로 생성한 번호를 반환
--              - 시퀀스를 생성하고 바로 사용하면 번호가 만들어진적이 없으므로 오류가 발생 => 처음 시퀀스를 만든 경우 NEXTVAL을 먼저 조회해야 한다.)
-- NEXTVAL : 다음 번호를 생성

-- 1) 처음 시퀀스를 만든 경우 NEXTVAL(다음 번호생성)로 SQL을 만든다.
SELECT dept_seq.nextval 
  from dual;  -- 10

-- 2) 그 후 CURRVAL로 값을 조회한다.
SELECT dept_seq.currval
  FROM dual; -- 10

-- ///////////////////////////////////////////////////
DROP TABLE dept_seq_tbl;
CREATE TABLE dept_seq_tbl(
    deptno      NUMBER(3),      -- PK
    deptname    VARCHAR2(50) NOT NULL,
    loc         VARCHAR2(50),
    CONSTRAINT dept_seq_tbl_deptno_pk primary key(deptno)
);

-- 사원테이블 생성(자식테이블 생성)
DROP TABLE emp_seq_tbl;
CREATE TABLE emp_seq_tbl(
    empno       NUMBER(3), -- PK
    ename       VARCHAR2(30) not null,
    hire_date   DATE default sysdate,
    salary      NUMBER(9) constraint emp_seq_tbl_salary_min check(salary > 0),
    deptno      NUMBER(3),  -- FK
    email       VARCHAR2(100), -- UNIQUE
    constraint emp_seq_tbl_empno_pk primary key(empno),
    constraint emp_seq_tbl_deptno_fk foreign key(deptno) references dept_seq_tbl(deptno)
            ON DELETE CASCADE, -- 자식 테이블에 설정하면, 부모테이블 데이터 삭제 시, 자식테이블 데이터도 같이 삭제
    constraint emp_seq_tbl_email_uk unique(email)
);

-- [ ex_dept_sequence 생성 => 부서테이블과 사원테이블의 부서번호 대체, 
-- [ ex_emp_sequence 생성 => 사원테이블의 사번 대체 ]
-- [ DEPT_SEQ_TBL ] 10~50 10씩 증가 
DROP SEQUENCE ex_dept_sequence;
CREATE SEQUENCE ex_dept_sequence
    START WITH 10
    INCREMENT BY 10
    MINVALUE 0
    MAXVALUE 50
    NOCYCLE;

-- [ EMP_SEQ_TBL ] 101~105 1씩 증가 ----------------------
DROP SEQUENCE ex_emp_sequence;
CREATE SEQUENCE ex_emp_sequence
    START WITH 101
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 105
    NOCYCLE;
    
INSERT INTO dept_seq_tbl
    VALUES(ex_dept_sequence.nextval, 'IT', '뉴욕');

INSERT INTO EMP_SEQ_TBL
    VALUES(ex_emp_sequence.nextval, '아이유', '24/01/01', 10000, ex_dept_sequence.currval, 'iu@email.com');

INSERT INTO dept_seq_tbl
    VALUES(ex_dept_sequence.nextval, '마케팅', '캐나다');

INSERT INTO EMP_SEQ_TBL
    VALUES(ex_emp_sequence.nextval, '방탄소년단', '24/02/01', 20000, ex_dept_sequence.currval, 'bts@email.com');

INSERT INTO dept_seq_tbl
    VALUES(ex_dept_sequence.nextval, '회계', '파리');

INSERT INTO EMP_SEQ_TBL
    VALUES(ex_emp_sequence.nextval, '소지섭', '24/03/01', 30000, ex_dept_sequence.currval, 'cow@email.com');

INSERT INTO dept_seq_tbl
    VALUES(ex_dept_sequence.nextval, '인사과', '맨하튼');

INSERT INTO EMP_SEQ_TBL
    VALUES(ex_emp_sequence.nextval, '박나래', '24/04/01', 40000, ex_dept_sequence.currval, 'park@email.com');

INSERT INTO dept_seq_tbl
    VALUES(ex_dept_sequence.nextval, '경리과', '서울');

INSERT INTO EMP_SEQ_TBL
    VALUES(ex_emp_sequence.nextval, '유느님', '24/05/01', 50000, ex_dept_sequence.currval, 'you@email.com');

SELECT * from dept_Seq_tbl;
SELECT * from emp_Seq_tbl;
