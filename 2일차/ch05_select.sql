/* 5장
 * [비교연산자]
 * - 같다 : =
 * - 같지않다 : <>, !=, ^=
 * - >, <, >=, <=
 */
 
-- **************************************
-- [ 2일차 ]
-- 실습 5-1. 사원테이블의 사번, 이메일, 급여, 부서, 입사일 조회(단, 부서코드가 60, 100일 때)
SELECT employee_id      -- 사번
     , email            -- 이메일
     , salary           -- 급여
     , department_id    -- 부서코드
     , hire_Date        -- 입사일
  FROM employees
 WHERE department_id = 60
    OR department_id = 100;
    
-- 실습 5-2. 사원테이블에서 사번, last_name, 직무코드, 급여를 조회
-- 단 급여가 10000이상이고, 사번이 150이상이고, last_name이 Ozer인 사원
SELECT employee_id      -- 사번
     , last_name        -- last_name
     , job_id           -- 직무코드
     , salary           -- 급여
  FROM employees
 WHERE salary >= 10000
   AND employee_id >= 150
   AND last_name = 'Ozer';

-- 실습 5-3. 사원테이블에서 사번, 입사일, 급여, 부서ID 조회
-- 단 급여는 15000이상, 부서ID 오름차순, 급여 내림차순
SELECT employee_id
     , hire_date
     , salary
     , department_id
  FROM employees
 WHERE salary >= 15000
 ORDER BY department_id, salary desc;
--100	03/06/17	24000	90
--102	01/01/13	17000	90
--101	05/09/21	17000	90

-- 실습 5-4. 부서테이블에서 부서ID가 50번 미만인 사원의 부서ID, 부서명, 매니저ID 조회
SELECT department_id
     , department_name
     , manager_id
  FROM departments
 WHERE department_id < 50;
 
--10	Administration	200
--20	Marketing	    201
--30	Purchasing	    114
--40	Human Resources	203

-- 실습 5-5. 급여가 10000이상 11000이하인 사원의 사번, salary 조회(정렬)
SELECT employee_id
     , salary
  FROM employees
 WHERE salary >= 10000
   AND salary <= 11000
   ORDER BY salary;

 -- 날짜 / 문자 데이터 조회
 -- 실습 5-6. 사원테이블에서 last_name이 King이거나
 -- 입사일이 05/07/16인 사원의 사번, last_name, 입사일 조회
SELECT employee_id
     , last_name
     , hire_date
  FROM employees
 WHERE last_name = 'King'
    OR hire_Date = '05/07/16';
 
/* [IN 연산자] : 특정 컬럼의 값이 A,B,C 중에 하나라도 일치하면
 * 참이 되는 연산자이다 => 중요
 * - 형식 : 컬럼값 IN(A,B,C)
 *          컬럼값 NOT IN(A,B,C)
 */
-- 실습 5-7. 사원테이블에서 부서코드가 70,90,100인 사원의
-- 사번, last_name, 부서ID 조회
-- 단 부서코드 오름차순
SELECT employee_id
     , last_name
     , department_id
  FROM employees
 WHERE department_id IN(70, 90, 100)
 ORDER BY department_id;

/* 실습 5-8.
 * BETWEEN A AND B 연산자 => 중요
 * - WHERE 컬럼명 BETWEEN 최소값 AND 최대값
 */
 
-- 급여가 10000이상 11000이하인 사원의 사번, 급여 검색(정렬)
SELECT employee_id
     , salary
  FROM employees
 WHERE salary BETWEEN 10000 AND 11000
 ORDER BY salary;

-- 실습 5-9. 사원테이블에서 사번, 입사일 조회
-- 입사일은 04/12/31 ~ 05/01/30, 입사일 오름차순
SELECT employee_id
     , hire_date
  FROM employees
 WHERE hire_Date BETWEEN '04/12/31' AND '05/01/30'
 ORDER BY hire_date;
 
/*
 * LIKE 연산자와 와일드 카드 => 중요
 * - 컬럼명 LIKE Pattern
 * - 와일드 카드:
 * % => 길이와 상관없이 모든 문자 데이터를 의미
 * _ => 어떤 값이든 상관없이 한개의 문자 데이터를 의미
 */
 
-- 실습 5-9. 사원테이블에서 last_name의 3번째, 4번째 단어가 'tt'인 사원의
-- 사번, last_name 조회, 사번 오름차순
SELECT employee_id
     , last_name
  FROM employees
 WHERE last_name LIKE '__tt%'
 ORDER BY employee_id;

-- 실습 5-10. 사원테이블에서 'JONES'가 포함된 이메일 조회, 사번 오름차순
SELECT employee_id
     , email
  FROM employees
 WHERE email LIKE '%JONES%'
 ORDER BY employee_id;

-- 실습 5-11. 직무테이블에서 'REP'가 포함된 직무코드 조회
SELECT job_id
  FROM jobs
 WHERE job_id LIKE '%REP';

-- 실습 5-12-1. 사원테이블에서 'ul'이 포함된 사번, last_name 조회, 사번 오름차순
SELECT employee_id
     , last_name
  FROM employees
 WHERE last_name LIKE '%ul%'
 ORDER BY employee_id;
 
-- 실습 5-12-2. 사원테이블에서 'ul'이 포함되지 않은 사번, last_name 조회, 사번 오름차순
SELECT employee_id
     , last_name
  FROM employees
 WHERE last_name NOT LIKE '%ul%'
 ORDER BY employee_id;
 
/* 5-13
 * NULL : 미확정, 값이 정해져 있지 않아 알 수 없는 값 -> 연산 X, 대입 X, 비교 X
 * 연산시 관계 컬럼 값도 null로 바뀐다. 예) 커미션이 null이면 연봉도 null
 * - IS NULL, IS NOT NULL 예) 컬럼명 IS NULL, 컬럼명 IS NOT NULL
 
 
 -- PK(Primary Key) => 1.Unique(데이터가 중복되지 않아야 한다.) 2. NOT NULL(필수)
 */
-- 실습 5-13-1. 사원테이블에서 부서코드가 null이 아닌 모든 행을 조회
-- 부서코드로 오름차순
SELECT employee_id
  FROM employees
 WHERE department_id IS NOT NULL
 ORDER BY department_id;

-- 실습 5-13-2. 사원테이블의 사번, last_name, 급여, 급여*12+커미션을 연봉, 커미션을 조회
-- 급여 >= 10000, 커미션이 널이 아닐 때
SELECT employee_id
     , last_name
     , salary
     , (salary * 12 + commission_pct) 연봉
  FROM employees
 WHERE salary >= 10000
   AND commission_pct IS NOT NULL
 ORDER BY salary;
   
/*
 * 5-14. 합집합
 * -- UNION : 중복제거 / UNION ALL 중복허용
 * -- ORDER BY는 문장의 맨끝
 * -- 합집합, 교집합(INTERSECT), 차집합(MINUS)은 테이블간에 컬럼 개수와 자료형이 일치해야 한다. 테이블은 달라도 무관
 *
 */
-- UNION ALL -- 중복허용 - 20번부서의 사번, 이름, 급여, 부서코드
SELECT employee_id
     , last_name
     , salary
     , department_id
     , email
  FROM employees
 WHERE department_id = 10 -- 200	Whalen	4400	10
 UNION 
SELECT employee_id
     , last_name
     , salary
     , department_id
     , email
  FROM employees
 WHERE department_id = 20;
--201	Hartstein	13000	20
--202	Fay	        6000	20

SELECT employee_id
     , last_name
     , salary
     , department_id
  FROM employees
 WHERE department_id = 20 -- 200	Whalen	4400	10
 UNION ALL
SELECT employee_id
     , last_name
     , salary
     , department_id
  FROM employees
 WHERE department_id = 20;

-- 차집합 : MINUS - 10번을 제외한 부서의 사번, 이름, 급여, 부서코드 => 전체 사원정보 - 10번부서의 사원정보
SELECT employee_id
     , last_name
     , salary
     ,department_id
  FROM employees
 MINUS
SELECT employee_id
     , last_name
     , salary
     ,department_id
  FROM employees
 WHERE department_id = 10
 ORDER BY department_id;
 
-- 교집합(INTERSECT)
SELECT employee_id
     , last_name
     , salary
     ,department_id
  FROM employees    -- 전체 사원정보
INTERSECT
SELECT employee_id
     , last_name
     , salary
     ,department_id
  FROM employees
 WHERE department_id = 10
 ORDER BY department_id;