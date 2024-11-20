-- 열(컬럼), 행(로우), 테이블(데이터가 저장되는 장소)
-- KEY => PK(primary Key), FK(Foreign Key)
-- 화면 입력 -> DTO(setter -> 멤버변수 -> getter) -> DB(List에 DTO정보를 add -> 테이블에 저장)
/* ctrl + shift + y 소문자
 * ctrl + shift + x 대문자
 * SELECT * FROM 테이블명;
 *
 *   SELECT 컬럼1, 컬럼2... FROM 테이블명
 *    WHERE 조건절 => 행에 대한 조건절
 *    ORDER BY 컬럼명 ASC; => SELECT문 맨끝에 온다. 여러열 지정가능,
 *    정렬할 데이터가 동일하면, 그 뒤에 오는 데이터의 정렬방식을 따른다.
 *      ASC(오름차순이며 생략가능), DESC(내림차순);
 */

-- 실습 4-1.
-- SELECT * FROM 테이블명;
SELECT *
  FROM employees;     -- 모든 사원정보 조회

-- First_Name 내림차순, 이메일 내림차순, 입사일순 내림차순
SELECT first_name
       , email
       , hire_date
  FROM employees
  ORDER BY first_name asc, email desc, hire_date desc;

-- 부서코드 오름차순, hire_date 내림차순
SELECT department_id
     , hire_Date
  FROM employees
  ORDER BY department_id, hire_Date desc;

-- 실습 4-2. 사번, 이메일, 급여, 부서코드 조회(사번이 100번일 때)
SELECT employee_id      -- 사번
     , email            -- 이메일
     , salary           -- 급여
     , department_id    -- 부서코드
  FROM employees
 WHERE employee_id = 100;
 
-- 실습 4-2-1. 사번, First_name, 이메일, 입사일, 급여, 부서코드, 직무코드 조회(사번이 206번일 때)
SELECT employee_id      -- 사번
     , first_name       -- First_name
     , email            -- 이메일
     , hire_date        -- 입사일
     , salary           -- 급여
     , department_id    -- 부서코드
     , job_id           -- 직무코드
  FROM employees
 WHERE employee_id = 206;

-- 실습 4-3. 모든 부서정보 조회
SELECT *
  FROM departments;   
  
-- 실습 4-4. 부서테이블에서 부서코드, 부서명, 지역코드 조회
SELECT department_id        -- 부서코드
     , department_name      -- 부서명
     , location_id          -- 지역코드
  FROM departments;

-- 실습 4-4-1. 부서테이블에서 사람의 부서코드, 부서명, 지역코드 조회(부서코드가 110번일때)
 SELECT department_id     -- 부서코드
      , department_name   -- 부서명 
      , location_id       -- 지역코드
   FROM departments         
  WHERE department_id = 110;

-- 실습 4-5. 지역테이블 전체조회
SELECT *
  FROM locations;
  
-- 실습 4-5-1. 지역테이블에서 사원의 지역코드, 주소, 도시, 국가코드 조회(지역코드가 1700번)
 SELECT location_id         -- 위치코드
      , street_address      -- 주소
      , city                -- 도시
      , country_id          -- 국가코드
   FROM locations
  WHERE location_id = 1700;

-- 실습 4-7. 국가테이블 전체조회
SELECT *
  FROM countries;
  
-- 실습 4-7-1. 국가ID, 국가명, 지역코드(국가코드가 US일 때)
SELECT country_id           -- 국가ID
     , country_name         -- 국가명
     , region_id            -- 지역코드
  FROM countries
 WHERE country_id = 'US';   -- '문자열', 대소문자 구분 ex)"문자열"은 에러

-- 실습 4-8. 직무테이블 조회
SELECT *
  FROM jobs;

-- 실습 4-8-1. William의 직무코드, 직무타이틀, 최소급여 조회(직무코드가 AC_Account일 때)
SELECT job_id       -- 직무코드
     , job_title    -- 직무타이틀
     , min_salary   -- 최소급여
  FROM jobs
 WHERE job_id = 'AC_ACCOUNT';
 
-- 실습 4-9. 직무히스토리 테이블 조회
SELECT *
  FROM job_history;
  
-- 실습 4-9-1. 직무히스토리 테이블에서 job_id가 AC_ACCOUNT인 사원의 사번, 시작일, 종료일, 부서코드 조회
SELECT employee_id          -- 사번
     , start_date           -- 시작일
     , end_date             -- 종료일
     , department_id        -- 부서코드
  FROM job_history
 WHERE job_id = 'AC_ACCOUNT';

-- 실습 4-10. 사원 테이블에서 부서코드(단 부서코드를 중복없이 내림차순으로 출력)
SELECT DISTINCT department_id
  FROM employees
  ORDER BY department_id desc;
  
-- 컬럼의 값이 동일하더라도 뒤의 컬럼이 다르면 중복 안된 데이터로 인지되어 DISTINCT가 적용되지 않는다.
SELECT DISTINCT department_id
     , manager_id
  FROM employees
  ORDER BY department_id desc;

---------------------------------------------
-- [DESC 테이블의 구조 : DESC(DESCRIBE) 테이블명] -- 테이블의 구조 파악
-- NOT NULL : 필수
DESC employees;

-- [DISTINCT] : 열 중복데이터를 삭제
-- DISTINCT + 중복 피할 컬럼
-- 열이 여러개인 경우, 여러개의 열까지 모두 동일해야 중복데이터로 간주

--
--
-- [별칭]
-- 컬럼명 : 한칸 띄우고 별칭, 한칸 띄우고 "별칭", 한칸 띄우고 AS 별칭, 한칸 띄우고 AS "별칭"
-- 테이블명 : 한칸 띄우고 영문별칭

SELECT first_name ||' '|| last_name 이름
     , email 이메일
     , hire_date 입사일
     , salary * 12 + commission_pct 연봉 -- 값이 null이면 비교, 연산, 할당 불가
  FROM employees;

SELECT first_name ||' '|| last_name 이름 -- ||은 문자열 연결
     , email 이메일
     , hire_date 입사일
     , salary * 12 + NVL(commission_pct, 0) 연봉 -- 값이 null이면 비교, 연산, 할당 불가(여기서는 
  FROM employees;

