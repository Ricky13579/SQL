-- 사원 테이블에서 급여가 10000보다 더 적은 사원들의 사번, 급여, 이메일을 조회
-- 급여에는 반드시 앞에 $를 붙일 것, 급여 오름차순
SELECT employee_id
     , '$'||salary 급여
     , email
  FROM employees
 WHERE salary < 10000
 ORDER BY salary ASC;
 
-- 급여가 7000에서 8000사이인 사원의 사번, 급여를 조회
-- 급여 오름차순
SELECT employee_id
     , salary
  FROM employees
 WHERE salary BETWEEN 7000 AND 8000
 ORDER BY salary;

-- 직무테이블에서 직무코드, 직무이름을 조회
-- 단, 직무코드의 4번째가 글자가 R인 것만 조회
SELECT job_id
     , job_title 
  FROM jobs
 WHERE job_id LIKE '___R%';

-- 사원테이블에서 이메일에 'Smith'가 포함된 사원과
-- 급여가 3000미만인 사원의 사번, 급여, 이메일 조회, 사번 오름차순(UNION 사용)
SELECT employee_id
     , salary
     , email
  FROM employees
 WHERE email LIKE '%SMITH%'
 UNION
SELECT employee_id
     , salary
     , email
  FROM employees
 WHERE salary < 3000
 ORDER BY employee_id;

-- 커미션이 null이 아닌 사원들의 사번, 급여, 커미션을 조회
-- 사번 오름차순
SELECT employee_id
     , salary
     , commission_pct
  FROM employees
 WHERE commission_pct IS NOT NULL
 ORDER BY employee_id;

-- 전체 사원에서 사장의 사번, 부서번호, 상사번호를 조회
SELECT employee_id   
     , department_id 
     , manager_id    
  FROM employees
INTERSECT
SELECT employee_id
     , department_id
     , manager_id
  FROM employees
 WHERE manager_id IS NULL;

-- 사장을 제외한 사원 중 부서번호가 30인 사원의 사번, 부서번호를 조회
-- 사번 오름차순
SELECT employee_id  
     , department_id 
     , manager_id   
  FROM employees
 MINUS
SELECT employee_id
     , department_id
     , manager_id
  FROM employees
 WHERE manager_id IS NULL
INTERSECT
SELECT employee_id  
     , department_id 
     , manager_id   
  FROM employees
 WHERE department_id = 30
 ORDER BY employee_id;

-- 국가테이블에서 국가이름이 'a'로 끝나지 않는 국가의 국가코드, 국가이름을 조회
SELECT country_id
     , country_name
  FROM countries
 WHERE country_name LIKE '%a'
 ORDER BY country_id;