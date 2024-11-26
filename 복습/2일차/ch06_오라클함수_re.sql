-- 사원테이블에서 사번, 이름,주민등록번호를 조회
-- 단, 주민등록번호는 입사일을 이용해서 조회, 뒷자리는 전부 *로 출력
-- 이름(first-last)
-- 사번 오름차순
SELECT employee_id AS "사번"
     , first_name || '-' || last_name AS "이름"
     , RPAD(REPLACE(hire_date,'/','')||'-',14,'*') AS "주민등록번호"
  FROM employees
 ORDER BY employee_id ASC;

-- 사원테이블에서 사번, 전화번호를 조회
-- 전화번호는 (___-____-____)형식으로 조회, 사번 오름차순
SELECT employee_id 사번
     , REPLACE(phone_number, '.', '-') 전화번호
  FROM employees
  ORDER BY employee_id;

-- 전화번호를 dual 테이블에서 나오게 하되 010만 나오게 출력
SELECT RPAD(RPAD('010',4,'-'), 8, '*')|| RPAD('-', 5, '*') 전화번호 
  FROM dual;

-- 사원테이블에서 부서번호가 30인 사번, 이름, 이메일을 조회
-- 이메일은 네이버 이메일로 나오게 조회
-- 사번 오름차순
SELECT employee_id
     , first_name || ' ' || last_name 이름
     , RPAD(email, LENGTH(email)+LENGTH('@naver.com'), '@naver.com') 이메일 
     , department_id 부서번호
  FROM employees
 WHERE department_id = 30
 ORDER BY employee_id;

-- 국가 테이블에서 국가 이름이 A로 시작하는 나라를 조회
SELECT country_id
     , country_name
  FROM countries
 WHERE country_name LIKE 'A%';

-- 사원테이블에서 사번, 이메일을 조회
-- 이메일은 첫글자만 대문자, 나머지는 소문자로 조회, 사번 오름차순
SELECT employee_id 사번
     , INITCAP(email) 이메일
  FROM employees
 ORDER BY employee_id;

-- 사원테이블에서 사번, 이메일을 조회
-- 이메일은 첫글자만 대문자, 나머지는 소문자로 조회
-- 단, 이메일의 첫글자가 대문자 B인 사원만 조회, 사번 오름차순
SELECT employee_id 사번
     , INITCAP(email) 이메일
  FROM employees
 WHERE email LIKE 'B%'
 ORDER BY employee_id;

-- '놀면 뭐하니'란 예능의 길이를 dual 테이블로 조회
-- LENGTH, LENGTHB 둘 다 사용
SELECT LENGTH('놀면 뭐하니') 길이 FROM DUAL;
SELECT LENGTHB('놀면 뭐하니') 길이 FROM DUAL;

-- 사원들의 사번, 이름(first-last), 급여(급여 : ____원)을 조회
-- 단 급여가 10000 이상인 사원들만, 급여 내림차순
SELECT employee_id
     , first_name || '-' || last_name 이름
     , '급여 : '||salary||'원' 급여
  FROM employees
 WHERE salary >= 10000
 ORDER BY salary DESC;