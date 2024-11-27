CREATE TABLE member_tb1_tr_re
    AS SELECT * FROM member_tb1_re;
SELECT * FROM member_tb1_tr_re;

-- 이강인 이메일 변경
UPDATE member_tb1_tr_re
   SET mem_name_re = '이강인'
     , mem_email_re = 'lki@mail.com'
 WHERE mem_id_re = 101;

savepoint soccer1;

-- 이강인 주소 변경
UPDATE member_tb1_tr_re
   SET mem_address_re = '발렌시아'
 WHERE mem_id_re = 101;
 
savepoint soccer2;

-- 호날두 정보 삭제
DELETE FROM member_tb1_tr_re
 WHERE mem_id_re = 102;

savepoint soccer3;

-- 이강인 정보 삭제
DELETE FROM member_tb1_tr_re
 WHERE mem_id_re = 101;

savepoint soccer4;

rollback to soccer3; -- 이강인 정보 삭제 전
rollback to soccer2; -- 호날두 정보 삭제 전
rollback to soccer1; -- 이강인 주소 변경 전
rollback;            -- 이강인 이메일 변경 전

-- 테이블 목록
SELECT table_name
  FROM user_tables;

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
 
-- 구조, 데이터까지 복사(단 제약조건은 복사안됨)
-- scott_04 계정에서
CREATE TABLE emp_idx_tbl_re
AS
SELECT * FROM emp_tbl_re;

CREATE TABLE dept_idx_tbl_re
AS
SELECT * FROM dept_tbl_re;

SELECT * FROM emp_tbl_re;
SELECT * FROM dept_tbl_re;

-- 비고유 인덱스
DROP INDEX idx_emp_ename_re;
CREATE INDEX idx_emp_ename_re 
    ON emp_idx_tbl_re(ename_re);  -- ON 테이블명(컬럼)

SELECT index_name
     , table_name
     , column_name
  FROM USER_IND_COLUMNS
 WHERE table_name = 'EMP_IDX_TBL_RE';

-- 고유 인덱스 
DROP INDEX idx_dept_deptno_re;
CREATE UNIQUE INDEX idx_dept_deptno_re
    ON dept_idx_tbl_re(deptno_re);

SELECT index_name
     , table_name
     , column_name
  FROM USER_IND_COLUMNS
 WHERE table_name = 'DEPT_IDX_TBL_RE';

-- 결합 인덱스
DROP INDEX idx_dept_com_re;
CREATE INDEX idx_dept_com_re
    ON dept_idx_tbl_re(deptname_re, loc_re);

SELECT index_name
     , table_name
     , column_name
  FROM USER_IND_COLUMNS
 WHERE table_name = 'DEPT_IDX_TBL_RE';
 
-- 함수기반 인덱스
DROP INDEX idx_emp_salary;
CREATE INDEX idx_emp_salary
    ON emp_idx_tbl(salary * 12);

SELECT index_name
     , table_name
     , column_name
  FROM USER_IND_COLUMNS
 WHERE table_name = 'EMP_IDX_TBL';

DROP SEQUENCE dept_seq_re;
CREATE SEQUENCE dept_seq_re
    START WITH 10
    INCREMENT BY 10
    MAXVALUE 90
    MINVALUE 0
    NOCYCLE;

SELECT *
  FROM USER_SEQUENCES;
  
-- 1) 처음 시퀀스를 만든 경우 NEXTVAL(다음 번호생성)로 SQL을 만든다.
SELECT dept_seq_re.nextval 
  from dual;  -- 10

-- 2) 그 후 CURRVAL로 값을 조회한다.
SELECT dept_seq_re.currval
  FROM dual; -- 10

DROP TABLE dept_seq_tbl_re;
CREATE TABLE dept_seq_tbl_re(
    deptno_re      NUMBER(3),      -- PK
    deptname_re    VARCHAR2(50) NOT NULL,
    loc_re         VARCHAR2(50),
    CONSTRAINT dept_seq_tbl_deptno_re_pk primary key(deptno_re)
);

-- 사원테이블 생성(자식테이블 생성)
DROP TABLE emp_seq_tbl_re;
CREATE TABLE emp_seq_tbl_re(
    empno_re       NUMBER(3), -- PK
    ename_re       VARCHAR2(30) not null,
    hire_date_re   DATE default sysdate,
    salary_re      NUMBER(9) constraint emp_seq_tbl_salary_re_min check(salary_re > 0),
    deptno_re      NUMBER(3),  -- FK
    email_re       VARCHAR2(100), -- UNIQUE
    constraint emp_seq_tbl_empno_re_pk primary key(empno_re),
    constraint emp_seq_tbl_deptno_re_fk foreign key(deptno_re) references dept_seq_tbl_re(deptno_re)
            ON DELETE CASCADE, -- 자식 테이블에 설정하면, 부모테이블 데이터 삭제 시, 자식테이블 데이터도 같이 삭제
    constraint emp_seq_tbl_email_re_uk unique(email_re)
);

DROP SEQUENCE ex_dept_sequence_re;
CREATE SEQUENCE ex_dept_sequence_re
    START WITH 100
    INCREMENT BY 10
    MINVALUE 0
    MAXVALUE 140
    NOCYCLE;

DROP SEQUENCE ex_emp_sequence_re;
CREATE SEQUENCE ex_emp_sequence_re
    START WITH 101
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 105
    NOCYCLE;

Insert INTO dept_seq_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(ex_dept_sequence_re.nextval, 'FW', '오른쪽');

Insert Into emp_seq_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(ex_emp_sequence_re.nextval, '사카', '2024/01/01', 10000, ex_dept_sequence_re.currval, 'saka@email.com');

Insert INTO dept_seq_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(ex_dept_sequence_re.nextval, 'FW', '가운데');

Insert Into emp_seq_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(ex_emp_sequence_re.nextval, '케인', '2024/02/01', 20000, ex_dept_sequence_re.currval, 'kane@email.com');

Insert INTO dept_seq_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(ex_dept_sequence_re.nextval, 'FW', '왼쪽');

Insert Into emp_seq_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(ex_emp_sequence_re.nextval, '살라', '2024/03/01', 30000, ex_dept_sequence_re.currval, 'salah@email.com');
 
Insert INTO dept_seq_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(ex_dept_sequence_re.nextval, 'GK', '뒤쪽');

Insert Into emp_seq_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(ex_emp_sequence_re.nextval, '케파', '2024/04/01', 40000, ex_dept_sequence_re.currval, 'kepa@email.com');
 
Insert INTO dept_seq_tbl_re(deptno_re, deptname_re, loc_re)
 VALUES(ex_dept_sequence_re.nextval, 'FW', '전부');
 
Insert Into emp_seq_tbl_re(empno_re, ename_re, hire_date_re, salary_re, deptno_re, email_re)
 values(ex_emp_sequence_re.nextval, '굴리트', '2024/05/01', 50000, ex_dept_sequence_re.currval, 'gullit@email.com');
 
SELECT * FROM dept_seq_tbl_re;
SELECT * FROM emp_seq_tbl_re;

commit;