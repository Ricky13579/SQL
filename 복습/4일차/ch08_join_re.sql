-- 방법1.
-- 국가코드에 IT가 들어가는 국가의 정보만 조회
SELECT l.country_id 국가코드
     , c.country_name 국가이름
     , l.street_address 주소
  FROM countries c, locations l
 WHERE c.country_id = l.country_id
   AND l.country_id LIKE '%IT%';
   
-- 방법2.
SELECT l.country_id 국가코드
     , c.country_name 국가이름
     , l.street_address 주소
  FROM countries c
  JOIN locations l
    ON c.country_id = l.country_id
 WHERE l.country_id LIKE '%IT%';

-- 방법 1.
-- start_date가 01년인 사원의 사번, 직무코드, 시작일, 종료일 출력
SELECT e.employee_id 사번
     , j.job_id 직무코드
     , jh.start_Date 시작일
     , jh.end_date 종료일
  FROM employees e, jobs j, job_history jh
 WHERE e.employee_id = jh.employee_id
   AND e.job_id = j.job_id
   AND to_char(substr(jh.start_date,1,2)) = '01';

-- 방법 2.
SELECT e.employee_id 사번
     , j.job_id 직무코드
     , jh.start_Date 시작일
     , jh.end_date 종료일
  FROM employees e
  JOIN jobs j
    ON e.job_id = j.job_id
  JOIN job_history jh
    ON e.employee_id = jh.employee_id
 WHERE to_char(substr(jh.start_date,1,2)) = '01';

-- 직무코드가 PU_CLERK인 사원의 사번, 직무코드, 직무이름 조회
-- 방법 1.
SELECT e.employee_id 사번
     , j.job_id 직무코드
     , j.job_title 직무이름
  FROM employees e, jobs j
 WHERE e.job_id = j.job_id
   AND j.job_id = 'PU_CLERK';

-- 방법 2.
SELECT e.employee_id 사번
     , j.job_id 직무코드
     , j.job_title 직무이름
  FROM employees e
  JOIN jobs j
    ON e.job_id = j.job_id
 WHERE j.job_id = 'PU_CLERK';

-- 직무코드가 PU_CLERK인 사원의 사번, 이름, 직무코드, 직무이름, 부서코드, 부서이름 조회
-- 방법 1
SELECT e.employee_id 사번
     , e.first_name || '-' || e.last_name 이름
     , j.job_id 직무코드
     , j.job_title 직무이름
     , d.department_id 부서코드
     , d.department_name 부서이름
  FROM employees e, jobs j, departments d
 WHERE e.job_id = j.job_id
   AND e.department_id = d.department_id
   AND j.job_id = 'PU_CLERK';

-- 방법2
SELECT e.employee_id 사번
     , e.first_name || '-' || e.last_name 이름
     , j.job_id 직무코드
     , j.job_title 직무이름
     , d.department_id 부서코드
     , d.department_name 부서이름
  FROM employees e
  JOIN jobs j
    ON e.job_id = j.job_id
  JOIN departments d
    ON d.department_id = e.department_id
 WHERE j.job_id = 'PU_CLERK';

-- 직무코드가 PU_CLERK인 사원의 사번, 직무코드, 직무이름, 부서코드, 부서이름, 지역번호, 주소를 조회
-- 방법 1
SELECT e.employee_id 사번
     , e.first_name || '-' || e.last_name 이름
     , j.job_id 직무코드
     , j.job_title 직무이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.country_id 지역번호
     , l.street_address 주소
  FROM employees e, jobs j, departments d, locations l
 WHERE e.job_id = j.job_id
   AND e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND j.job_id = 'PU_CLERK';

-- 방법2
SELECT e.employee_id 사번
     , e.first_name || '-' || e.last_name 이름
     , j.job_id 직무코드
     , j.job_title 직무이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.country_id 지역번호
     , l.street_address 주소
  FROM employees e
  JOIN jobs j
    ON e.job_id = j.job_id
  JOIN departments d
    ON d.department_id = e.department_id
  JOIN locations l
    ON d.location_id = l.location_id
 WHERE j.job_id = 'PU_CLERK';

-- 직무코드가 PU_CLERK인 사원의 사번, 직무코드, 직무이름, 부서코드, 부서이름
-- 지역번호, 주소, 국가번호, 국가이름을 조회
-- 방법 1
SELECT e.employee_id 사번
     , e.first_name || '-' || e.last_name 이름
     , j.job_id 직무코드
     , j.job_title 직무이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.country_id 지역번호
     , l.street_address 주소
     , c.country_id 국가번호
     , c.country_name 국가이름
  FROM employees e, jobs j, departments d, locations l, countries c
 WHERE e.job_id = j.job_id
   AND e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND j.job_id = 'PU_CLERK';

-- 방법2
SELECT e.employee_id 사번
     , e.first_name || '-' || e.last_name 이름
     , j.job_id 직무코드
     , j.job_title 직무이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.country_id 지역번호
     , l.street_address 주소
     , c.country_id 국가번호
     , c.country_name 국가이름
  FROM employees e
  JOIN jobs j
    ON e.job_id = j.job_id
  JOIN departments d
    ON d.department_id = e.department_id
  JOIN locations l
    ON d.location_id = l.location_id
  JOIN countries c
    ON l.country_id = c.country_id
 WHERE j.job_id = 'PU_CLERK';

SELECT d.location_id 지역코드_D
     , l.location_id 지역코드_L
     , d.department_name 부서이름
     , l.street_address 주소
  FROM departments d, locations l
 WHERE d.location_id(+) = l.location_id;

SELECT d.location_id 지역코드_D
     , l.location_id 지역코드_L
     , d.department_name 부서이름
     , l.street_address 주소
  FROM departments d
  RIGHT OUTER JOIN locations l
  ON d.location_id = l.location_id;

SELECT d.location_id 지역코드_D
     , l.location_id 지역코드_L
     , d.department_name 부서이름
     , l.street_address 주소
  FROM departments d
  FULL OUTER JOIN locations l
  ON d.location_id = l.location_id;
