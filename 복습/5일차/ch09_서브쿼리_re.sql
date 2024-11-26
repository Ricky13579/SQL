-- last_name이 Ozer인 사람의 급여보다 더많은 급여를 받는 사원의 정보
SELECT employee_id 사번
     , last_name 이름
     , job_id 직무코드
     , salary 급여
     , department_id 부서코드
  FROM employees
 WHERE salary > (SELECT salary
                   FROM employees
                  WHERE last_name = 'Ozer')
 ORDER BY employee_id;

-- 'Ozer'과 같은 부서(=100)에서 일하는 사원의 사번, 이름, 부서번호, 부서명을 구하시오(사번 오름차순)
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서명
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
   AND d.department_id = (SELECT department_id
                            FROM employees
                           WHERE last_name = 'Ozer')
 ORDER BY e.employee_id;

-- 3) job_title이 'Accountant'인 사원과 같은 직무에서 일하는 사원의
-- 사번, 사원명, 직무코드, 급여 출력
SELECT e.employee_id 사번
     , e.last_name 이름
     , j.job_id 직무코드
     , e.salary 급여
  FROM employees e, jobs j
 WHERE e.job_id = j.job_id
   AND j.job_title = (SELECT job_title
                        FROM jobs
                       WHERE job_title = 'Accountant')
ORDER BY e.employee_id;

-- 각 직무별 최소 급여만큼 받는 사원정보
SELECT employee_id 사번
     , last_name 이름
     , job_id 직무코드
     , salary 급여
     , department_id 부서코드
  FROM employees
 WHERE salary IN (SELECT min(salary)
                   FROM employees
                  GROUP By job_id
 );

-- 직무코드가 'ST_MAN'의 최소급여(5800)보다 더 적게 받는 사원정보
SELECT employee_id 사번
     , last_name 이름
     , job_id 직무코드
     , salary 급여
     , department_id 부서코드
  FROM employees
 WHERE salary < ANY(SELECT min(salary)
                   FROM employees
                   WHERE job_id = 'ST_MAN'
                    )
 ORDER BY salary;

SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE salary < ALL(SELECT salary -- 최소 salary(6000)
                      FROM employees 
                  WHERE department_id = 20)
ORDER BY salary;

SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE salary > ALL(SELECT salary -- 최대 salary(13000)
                      FROM employees 
                  WHERE department_id = 20)
ORDER BY salary;

SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE EXISTS(SELECT department_name  -- 0번 부서는 없음
                FROM departments 
               WHERE department_id = 0)
ORDER BY salary; 

SELECT d.department_id  부서코드
     , d.department_name 부서명
     , l.location_id 위치코드
     , l.street_address 주소
 FROM (SELECT * FROM departments
        WHERE location_id = 1500) d
    , (SELECT * FROM locations) l
 WHERE d.location_id = l.location_id;

WITH
    d AS (SELECT * FROM departments
            WHERE location_id = 1500),
    l AS (SELECT * FROM locations)
SELECT d.department_id   부서코드
     , d.department_name 부서명
     , l.location_id 위치코드
     , l.street_address 주소
  FROM d, l
 WHERE d.location_id = l.location_id;