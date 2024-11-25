-- 직무별 평균급여
SELECT job_id "직무코드"
     , ROUND(AVG(salary), 2) "직무별 평균급여"
  FROM employees
 GROUP BY job_id
 ORDER BY job_id;

-- 사원테이블에서 부서별 총급여, 최대급여 구하기(소수점이하 2째자리), 최소급여, 직무정렬
SELECT department_id 부서번호
     , SUM(salary) "직무별 총급여"
     , max(salary) "직무별 최대급여"
     , min(salary) "직무별 최소급여"
  FROM employees
 GROUP BY department_id
 ORDER BY department_id;

-- 직무별 최대급여, 총급여(단 총 급여가 8000이하), 직무코드 오름차순
-- 직무코드 없으면 제외
SELECT job_id "직무코드"
     , max(salary) "최대급여"
     , sum(salary) "총급여"
  FROM employees
 WHERE job_id is not null
 GROUP BY job_id
 HAVING sum(salary) <= 8000
 ORDER BY job_id;

-- 부서별 총급여, 평균급여(단 평균급여 3000 이상)
-- 소수점 이하는 무조건 버리기, 직무 오름차순(부서코드가 50보다 작으면 조회되면 안됨)
SELECT department_id 부서코드
     , max(salary) 총급여
     , trunc(Avg(Salary)) 평균급여
  FROM employees
 GROUP By department_id
 HAVING department_id > 50
 AND avg(salary) >= 8000
 ORDER BY department_id;

-- 직무별 직무코드,이름(first-last), 실제 받는 급여,최소급여, 최대급여(그룹함수 없음)
SELECT j.job_id "직무코드"
     , e.first_name || '-' || e.last_name 이름
     , e.salary "실제급여"
     , j.min_salary "부서별 최소급여"
     , j.max_salary "부서별 최대급여"
  FROM employees e, jobs j
 WHERE e.job_id = j.job_id;