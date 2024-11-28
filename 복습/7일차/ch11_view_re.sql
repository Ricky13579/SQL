CREATE OR REPLACE VIEW v_emp_dept_re
AS
SELECT e.empno_re 사번
     , e.ename_re 이름
     , e.hire_date_re 입사일
     , d.deptname_re 부서명
     , d.loc_re 위치정보
  FROM emp_tbl_re e
     , dept_tbl_re d
 WHERE e.deptno_re = d.deptno_re;

SELECT view_name, text
  FROM user_views;
  
SELECT *
  FROM v_emp_dept_re;

DROP table animal_tbl;
CREATE TABLE animal_tbl(
    animal_num   NUMBER(3) primary key, -- 번호
    name        VARCHAR2(100) not null, -- 이름
    food        VARCHAR2(50) not null,  -- 식성
    lifestyle   VARCHAR2(50) not null   -- 야행성 / 주행성
);

INSERT INTO animal_tbl(animal_num, name, food, lifestyle)
 VALUES(101, '호랑이', '육식', '주행성');
 
INSERT INTO animal_tbl(animal_num, name, food, lifestyle)
 VALUES(102, '사자', '육식', '야행성');

INSERT INTO animal_tbl(animal_num, name, food, lifestyle)
 VALUES(103, '얼룩말', '초식', '주행성');

INSERT INTO animal_tbl(animal_num, name, food, lifestyle)
 VALUES(104, '하이에나', '육식', '야행성');
 
INSERT INTO animal_tbl(animal_num, name, food, lifestyle)
 VALUES(105, '독수리', '육식', '주행성');

commit;

CREATE OR REPLACE VIEW v_animal
AS
SELECT animal_num
     , name
     , food
     , lifestyle
  FROM animal_tbl
 WHERE animal_num IN (101, 103, 105);

SELECT view_name, text
  FROM user_views;

SELECT * FROM v_animal;

DROP view v_animal;

CREATE OR REPLACE VIEW v_emp_readonly_re
AS
SELECT empno_re
     , ename_re
     , hire_date_re
     , salary_re
     , deptno_re
  FROM emp_tbl_Re
WITH READ ONLY;

SELECT view_name, text
  FROM user_views;

SELECT *
  FROM v_emp_readonly_re;

INSERT INTO v_emp_readonly_re(empno_re, ename_re, hire_Date_re, salary_re, deptno_re)
 VALUES(106, '네이마르', sysdate, 60000, 50);

CREATE OR REPLACE VIEW v_emp_chkoption_re
AS
SELECT empno_re
     , ename_re
     , hire_date_re
     , salary_re
     , deptno_re
     , email_re
  FROM emp_tbl_re
 WHERE empno_re IN (106, 107, 108) -- 지정한 제약조건을 만족하는 데이터에 한해 DML(I, U, D) 작업이 가능하도록 뷰 생성
WITH CHECK OPTION;

SELECT view_name, text
  FROM user_views;

SELECT * FROM v_emp_chkoption_re;

INSERT INTO v_emp_chkoption_re(empno_re, ename_re, hire_Date_re, salary_re, deptno_re)
 VALUES(106, '안정환', sysdate, 20000, 50);
 
INSERT INTO v_emp_chkoption_re(empno_re, ename_re, hire_Date_re, salary_re, deptno_re)
 VALUES(107, '이천수', sysdate, 30000, 50);

INSERT INTO v_emp_chkoption_re(empno_re, ename_re, hire_Date_re, salary_re, deptno_re)
 VALUES(108, '김남일', sysdate, 40000, 50);
 
-- view 데이터 조회
SELECT view_name, text
  FROM user_views;

SELECT * FROM v_emp_chkoption_re;

SELECT * FROM emp_tbl_re;

UPDATE v_emp_chkoption_re
   SET email_re = 'ajh@mail.com'
 WHERE empno_re = 106;

UPDATE v_emp_chkoption_re
   SET email_re = 'lcs@mail.com'
 WHERE empno_re = 107;
 
UPDATE v_emp_chkoption_re
   SET email_re = 'kni@mail.com'
 WHERE empno_re = 108;

UPDATE v_emp_chkoption
   SET email = 'kimss@mail.com'
 WHERE empno = 110; 
commit;

SELECT ROWNUM AS 순위
     , e.*
  FROM emp_tbl_re e;

SELECT rownum as 순위
     , e.*
  FROM emp_tbl_re e
 WHERE rownum <= 3;

SELECT ROWNUM AS 순위
     , e.*
  FROM (SELECT *
          FROM employees
         ORDER BY hire_date) e
 WHERE rownum <=5;
 
-- 최저 급여를 받는 사원 5명
SELECT ROWNUM AS 순위
     , e.*
  FROM (SELECT *
          FROM employees
         ORDER BY salary) e
 WHERE rownum <=5;

WITH
e AS 
(SELECT *
   FROM employees
  ORDER BY salary)
SELECT ROWNUM AS 순위
     , e.*
  FROM  e
 WHERE rownum <=5;