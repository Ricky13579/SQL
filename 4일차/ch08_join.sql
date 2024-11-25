/*
 * 8-1. join => 면접
 * 부서정보
 *
 * 정보를 제공하는 테이블 => 부모테이블 : 부서T => Primary Key(식별키, PK) => NOT NULL, Unique
 * 정보를 제공받는 테이블 => 자식테이블 : 사원T => Foreign Key(외래키, FK)
 *
 * - 형식
 * SELECT t1.column, t2.column
 *   FROM table t1, table t2
 *  WHERE t1.column = t2.column
 *    AND 조건식;
 * - 중복컬럼은 테이블명을 붙여야 한다.
 */
-- 부서테이블 조회(20번 부서) => 부모
SELECT *
  FROM departments
 WHERE department_id = 20;

-- 사원테이블 조회(20번 부서) => 자식
SELECT employee_id "사번"
     , first_name "이름"
     , department_id "부서코드"
  FROM employees
 WHERE department_id = 20;
 
-- 20번 부서의 부서ID, 부서명 조회
SELECT e.employee_id "사번"
     , e.first_name "이름"
     , e.department_id "부서ID" -- fk
     , d.department_id "부서ID" -- pk
     , d.department_name "부서명"
  FROM employees e, departments d
 WHERE d.department_id = e.department_id
   AND d.department_id = 20; -- 별칭 생략 시 에러, 두 테이블의 중복컬럼이므로
   
-- 사원정보, 부서정보
-- 사원테이블의 사번이 101번인 사원의 사번, 부서번호, 부서명 조회
-- 방법 1.
SELECT e.employee_id  "사번"
     , d.department_id "부서번호"
     , d.department_name "부서명"
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
   AND e.employee_id = 101;

-- 방법 2. JOIN ~ ON => ,를 JOIN으로 바꾸고, WHERE를 ON으로 바꾸고 첫 번째 AND를 WHERE로 바꾼다.
/*
 - JOIN ~ ON
 - 중복컬럼은 테이블명을 붙여야 함
 - 테이블명과 테이블명 사이에 콤마(,) 대신 JOIN을 사용하고
 - 공통으로 존재하는 키를 비교(조인조건)하는 WHERE 대신에 ON을 사용한다.
 - 다른 검색이나 필터조건은 WHERE절에 분리해서 기술한다.
 */
SELECT e.employee_id  "사번"
     , d.department_id "부서번호"
     , d.department_name "부서명"
  FROM employees e
  JOIN departments d
    ON e.department_id = d.department_id
 WHERE e.employee_id = 101;
 
-- 60번 부서(IT부서)에서 일하는 사원의 사번, last_name, 부서번호, 부서명
-- 방법1
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서번호
     , d.department_name 부서명
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
   AND d.department_id = 60;

-- 방법 2
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서번호
     , d.department_name 부서명
  FROM employees e
  JOIN departments d
    ON e.department_id = d.department_id
 WHERE d.department_id = 60;

---------------------------------------------
-- 1. [ 사원정보, 직무정보 ]
-- 사원테이블의 사번이 110번인 사원의 사번, last_name, 직무코드, 직무타이틀, 최소, 최대급여
-- 방법 1.
SELECT e.employee_id 사번
     , e.last_name 이름
     , j.job_id 직무코드
     , j.job_title 직무타이틀
     , j.min_salary 최소급여
     , j.max_salary 최대급여
  FROM employees e, jobs j
 WHERE e.job_id = j.job_id
   AND e.employee_id = 110;

-- 방법2.
SELECT e.employee_id 사번
     , e.last_name 이름
     , j.job_id 직무코드
     , j.job_title 직무타이틀
     , j.min_salary 최소급여
     , j.max_salary 최대급여
  FROM employees e
  JOIN jobs j
    ON e.job_id = j.job_id
 WHERE e.employee_id = 110;

-- [2. 사원정보, 부서정보, 위치정보 ]
-- 100번인 사원의 사번, last_name, 부서테이블의 부서코드, 부서명
-- 위치테이블의 location_id, street_address
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서명
     , l.location_id 위치명
     , l.street_address 주소
  FROM employees e, departments d, locations l
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND e.employee_id = 100;

-- 방법2
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서명
     , l.location_id 위치명
     , l.street_address 주소
  FROM employees e
  JOIN departments d
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
 WHERE e.employee_id = 100;

-----------------------------------------------
-- [3. 사원정보, 부서정보, 위치정보, 국가정보 ]
-- 100번인 사원의 사번, last_name, 부서테이블의 부서코드, 부서명
-- 위치테이블의 location_id, street_address, 국가테이블의 id, name
-- 방법 1.
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서명
     , l.location_id 위치명
     , l.street_address 주소
     , c.country_id 국가코드
     , c.country_name 국가이름
  FROM employees e, departments d, locations l, countries c
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND e.employee_id = 100;

-- 방법 2.
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서명
     , l.location_id 위치명
     , l.street_address 주소
     , c.country_id 국가코드
     , c.country_name 국가이름
  FROM employees e
  JOIN departments d
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
  JOIN countries c
    ON l.country_id = c.country_id
 WHERE e.employee_id = 100;

----------------------------------------------------------------
-- [3. 사원정보, 부서정보, 위치정보, 국가정보, 지역정보]
-- 100번인 사원의 사번, last_name, 부서테이블의 부서코드, 부서명
-- 위치테이블의 location_id, street_address, 국가테이블의 id, name, Regions 테이블의 region_id, region_name
-- 방법 1.
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.location_id 위치코드
     , l.street_address 주소
     , c.country_id 국가코드
     , c.country_name 국가이름
     , r.region_id 지역코드
     , r.region_name 지역이름
  FROM employees e, departments d, locations l, countries c, regions r
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND c.region_id = r.region_id
   AND e.employee_id = 100;

-- 방법2.
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.location_id 위치코드
     , l.street_address 주소
     , c.country_id 국가코드
     , c.country_name 국가이름
     , r.region_id 지역코드
     , r.region_name 지역이름
  FROM employees e
  JOIN departments d
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
  JOIN countries c
    ON l.country_id = c.country_id
  JOIN regions r
    ON c.region_id = r.region_id
 WHERE e.employee_id = 100;
 
----------------------------------------------------------------
-- [4. 사원정보, 부서정보, 위치정보, 국가정보, 지역정보]
-- 100번인 사원의 사번, last_name, 부서테이블의 부서코드, 부서명
-- 위치테이블의 location_id, street_address, 국가테이블의 id, name, Regions 테이블의 region_id, region_name
-- 방법 1.
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.location_id 위치코드
     , l.street_address 주소
     , c.country_id 국가코드
     , c.country_name 국가이름
     , r.region_id 지역코드
     , r.region_name 지역이름
  FROM employees e, departments d, locations l, countries c, regions r
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND c.region_id = r.region_id
   AND e.employee_id = 100;

-- 방법2.
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.location_id 위치코드
     , l.street_address 주소
     , c.country_id 국가코드
     , c.country_name 국가이름
     , r.region_id 지역코드
     , r.region_name 지역이름
  FROM employees e
  JOIN departments d
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
  JOIN countries c
    ON l.country_id = c.country_id
  JOIN regions r
    ON c.region_id = r.region_id
 WHERE e.employee_id = 100;

-- [5. 사원정보, 부서정보, 위치정보, 국가정보, 지역정보, 직무정보(현재), 직무history(이전)]
-- 101번인 사원의 사번, last_name, 부서테이블의 부서코드, 부서명, 위치테이블의 location_id, street_address
-- 국가테이블의 id, name, Regions 테이블의 region_id, region_name, 모든 직무정보
-- 직무history : start_date : '07/09/21'의 모든 정보
-- 방법 1.
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.location_id 위치코드
     , l.street_address 주소
     , c.country_id 국가코드
     , c.country_name 국가이름
     , r.region_id 지역코드
     , r.region_name 지역이름
     , j.*
     , jh.*
  FROM employees e, departments d, locations l, 
  countries c, regions r, jobs j, job_history jh
 WHERE e.department_id = d.department_id
   AND d.location_id = l.location_id
   AND l.country_id = c.country_id
   AND c.region_id = r.region_id
   AND jh.job_id = j.job_id
   AND e.employee_id = jh.employee_id
   AND e.employee_id = 101
   AND jh.start_date = '97/09/21';

-- 방법 2.
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서코드
     , d.department_name 부서이름
     , l.location_id 위치코드
     , l.street_address 주소
     , c.country_id 국가코드
     , c.country_name 국가이름
     , r.region_id 지역코드
     , r.region_name 지역이름
     , j.*
     , jh.*
  FROM employees e
  JOIN departments d
    ON e.department_id = d.department_id
  JOIN locations l
    ON d.location_id = l.location_id
  JOIN countries c
    ON l.country_id = c.country_id
  JOIN regions r
    ON c.region_id = r.region_id
  JOIN jobs j
    ON e.job_id = j.job_id
  JOIN job_history jh
    ON e.employee_id = jh.employee_id
 WHERE e.employee_id = 101
   AND jh.start_date = '97/09/21';

/*
 * 면접
 *      Outer join
 * 두 테이블간 조인에서 조인 기준열의 어느 한쪽이 null이어도 강제로 출력하는 방식을
 * 외부조인(outer join)이라고 한다.
 *
 * (+) => 부족한 쪽 즉 null일 떄 강제출력
 * - left outer join : left가 데이터가 많은 쪽 즉 기준이 되는 쪽임
 *      왼쪽 외부조인(Left Outer Join)
 *          예) WHERE table1.col1 = table2.col(+)
 *          또는 FROM table1 LEFT OUTER JOIN table2 ON 조인조건식
 *
 *
 * - right outer join : right가 데이터가 많은 쪽 즉 기준이 되는 쪽임
 *      오룬쪽 외부조인(Right Outer Join)
 *          예) WHERE table1.col1(+) = table2.col
 *          또는 FROM table1 RIGHT OUTER JOIN table2 ON 조인조건식
 *
 * - full outer join : FROM table1 FULL OUTER JOIN table2 ON 조인조건식
 */
-- 부서ID : 사원테이블(10 ~ 110, null)중복제거 => 11건, null
 
-- 부서테이블 조회(27건) => 부모 10 ~ 270
SELECT department_id
     , department_name
  FROM departments;

-- 사원테이블 조회(20번 부서) => 자식
SELECT DISTINCT department_id
  FROM employees
 ORDER BY department_id;
 
-- 방법 1.
SELECT d.department_id
     , d.department_name
     , e.employee_id
     , d.department_id "부서T-부서"
     , e.department_id "사원T-부서"
  FROM departments d
     , employees e
 WHERE d.department_id = e.department_id(+)
 ORDER BY d.department_id;

-- 방법 2.
SELECT d.department_id
     , d.department_name
     , e.employee_id
     , d.department_id "부서T-부서"
     , e.department_id "사원T-부서"
  FROM departments d
  LEFT OUTER JOIN employees e
  ON d.department_id = e.department_id
  ORDER BY d.department_id;

-- [ RIGHT OUTER JOIN ]
-- 오른쪽 테이블이 기준(모든 데이터를 가지고 있음), 왼쪽 테이블에 null 포함
-- 방법 1.
SELECT d.department_id
     , d.department_name
     , e.employee_id
     , d.department_id "부서T-부서"
     , e.department_id "사원T-부서"
  FROM departments d
     , employees e
 WHERE d.department_id(+) = e.department_id
 ORDER BY d.department_id;

-- 방법 2.
SELECT d.department_id
     , d.department_name
     , e.employee_id
     , d.department_id "부서T-부서"
     , e.department_id "사원T-부서"
  FROM departments d
  Right OUTER JOIN employees e
  ON d.department_id = e.department_id
  ORDER BY d.department_id; 

