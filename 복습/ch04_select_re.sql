-- 오라클 복습_1일차
 
-- 사원테이블에서 last_name이 King인 사원의 모든 정보를 조회
SELECT *                -- 모든 정보
  FROM employees
 WHERE last_name = 'King';

-- 직무테이블에서 회사 사장의 직무번호, 직무이름, 최소급여, 최대급여를 조회
SELECT job_id           -- 직무번호
     , job_title        -- 직무이름
     , min_salary       -- 최소급여
     , max_salary       -- 최대급여
  FROM jobs
 WHERE job_id = 'AD_PRES';

-- 부서테이블에서 사장의 부서번호와 부서이름 그리고 지역번호를 조회
SELECT department_id        -- 부서번호
     , department_name      -- 부서이름
     , location_id          -- 지역번호
  FROM departments
 WHERE department_id = 90;
 
-- 지역테이블에서 사장이 있는 부서의 주소, 도시, 그리고 국가번호를 조회
SELECT street_address       -- 주소
     , city                 -- 도시
     , country_id           -- 국가번호
  FROM locations
 WHERE location_id = 1700;

-- 국가테이블에서 사장이 있는 부서의 국가번호, 국가이름을 조회
SELECT country_id           -- 국가번호
     , country_name         -- 국가이름
  FROM countries
 WHERE country_id = 'US';

-- 사원테이블에서 job_id가 ST_CLERK인 사원의 급여, 상사번호를 조회
-- 급여 내림차순, 상사번호 오름차순
SELECT salary           -- 급여
     , department_id    -- 상사번호
  FROM employees
 WHERE job_id = 'ST_CLERK'
 ORDER BY salary desc, manager_id;
 
-- 사원테이블에서 입사일을 중복을 없애고 조회
SELECT DISTINCT hire_Date       -- 입사일(중복 제거)
  FROM employees;

-- 사원테이블에서 부서번호가 30인 사원의 사번, 이메일, 입사일, 급여를 조회
-- 입사일 내림차순
SELECT employee_id 사번
     , email "이메일"
     , hire_Date AS 입사일
     , salary AS "급여"
  FROM employees
 WHERE department_id = 30
 ORDER BY hire_date desc;
 
-- 사원테이블에서 사원들의 급여, 상사번호, 사번를 조회
-- 급여 오름차순, 상사번호 내림차순, 사번 내림차순
SELECT salary           -- 급여
     , manager_id       -- 상사번호
     , employee_id    -- 부서번호
  FROM employees
  ORDER BY salary, manager_id desc, employee_id desc;
        
  
