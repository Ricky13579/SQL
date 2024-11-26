/*
 서브쿼리

 * 메인쿼리 내부에 포함된 SELECT 문장이다. 
 * 즉 서브쿼리에서 실행된 결과가 메인쿼리에 전달되어 최종적인 결과를 출력한다. 
 * - 메인쿼리 : 서브쿼리를 포함하고 있는 쿼리문
 * - 서브쿼리 : 메인쿼리에 포함된 쿼리문으로, 비교연산자의 오른쪽에 기술하고, 반드시 괄호안에 넣어야 한다.
 *            메인쿼리가 실행되기 전에 한번만 실행된다.
 *            서브쿼리의 SELECT 절에 명시한 열은 메인쿼리의 비교대상과 같은 자료형과 같은 갯수로 지정해야 한다.
 
 * - 종류 : 단일행 서브쿼리, 다중행 서브쿼리
 *   - 단일행 서브쿼리 : 수행결과가 오직 하나의 행만을 반환하는 서브쿼리
 *            연산자 : >, >=, =, <=, <, <>, !=, ^=
 *   - 다중행 서브쿼리 : 수행결과가 하나이상의 행만을 반환하는 서브쿼리 
 *            연산자 : IN, ANY, SOME, ALL, EXISTS
 */
-- hr 계정에서 실행 
-- 1. 단일행 서브쿼리
-- 1) 'Chen'의 급여(=8200)보다 많은 급여를 받는 사원의 사번, 이름, 급여를 구하시오.(급여는 오름차순)
SELECT employee_id 사번
     , first_name || '-' || last_name 이름
     , salary 급여
  FROM employees
 WHERE salary > (SELECT salary
                   FROM employees
                  WHERE last_name = 'Chen')
 ORDER BY salary;

-- 2) 'Chen'과 같은 부서(=100)에서 일하는 사원의 사번, 이름, 부서번호, 부서명을 구하시오(사번 오름차순)
SELECT e.employee_id 사번
     , e.last_name 이름
     , d.department_id 부서번호
     , d.department_name 부서명
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
   AND e.department_id = (SELECT department_id
                            FROM employees
                           WHERE last_name = 'Chen')
 ORDER BY e.employee_id;

-- 3) job_title이 'Programmer'를 포함하는 사원과 같은 직무(IT_PROG)에서 일하는 사원의
-- 사번, 사원명, 직무코드, 급여 출력
SELECT e.employee_id 사번
     , e.last_name 사원명
     , e.job_id 직무코드
     , e.salary 급여
  FROM employees e, jobs j
 WHERE e.job_id = j.job_id
   AND e.job_id = (SELECT job_id
                     FROM jobs
                    WHERE job_title LIKE '%Programmer%');

/*
 * 2. 다중행 서브쿼리 : 수행결과가 하나이상의 행만을 반환하는 서브쿼리
 *                  연산자 : IN, ANY, SOME, ALL, EXISTS
 */
-- 1) IN : => 중요
-- 메인쿼리의 비교조건이 서브쿼리의 결과와 하나라도 일치하면 참
-- 사원테이블에서 20, 30, 40번 부서에서 근무하는 사원정보 출력(단, 부서번호 정렬)
SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE department_id IN (20, 30, 40)
 ORDER by department_id;

-- 각 부서별 최대 급여
SELECT department_id
     , max(salary)
  FROM employees
 GROUP BY department_id;

-- 각 부서별 최대 급여와 동일한 급여를 받는 사원정보
SELECT employee_id 사번
     , last_name 이름
     , job_id 직무코드
     , salary 급여
     , department_id 부서코드
  FROM employees
 WHERE salary IN (SELECT max(salary)
                   FROM employees
                  GROUP BY department_id)
 ORDER BY department_id;

-- 2) ANY, SOME - 메인쿼리의 비교조건이 서브쿼리의 결과와 하나 이상이 일치하면 참이다.
-- > ANY : 메인쿼리 결과값 > 서브쿼리의 최소값
-- < ANY : 메인쿼리 결과값 < 서브쿼리의 최대값

-- 30번 부서의 최소 급여보다 큰 정보
SELECT employee_id 사번
     , last_name 이름
     , job_id 직무코드
     , salary 급여
     , department_id 부서코드
  FROM employees
 WHERE salary > ANY(SELECT salary
                   FROM employees
                  WHERE department_id = 30)
 ORDER BY department_id;

-- 30번 부서의 최대 급여보다 큰 정보
SELECT employee_id 사번
     , last_name 이름
     , job_id 직무코드
     , salary 급여
     , department_id 부서코드
  FROM employees
 WHERE salary < ANY(SELECT salary
                   FROM employees
                  WHERE department_id = 30)
 ORDER BY department_id;
 
-- 3) ALL - 메인쿼리의 비교조건이 서브쿼리의 결과와 모두 일치하면 참이다.
--  > ALL : 메인쿼리 결과값 > 서브쿼리의 최대값
--  < ALL : 메인쿼리 결과값 < 서브쿼리는 최소값

-- 30번 부서의 최대 salary(11000)보다 큰 정보
SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE salary > ALL(SELECT salary -- 최대 salary(11000)
                      FROM employees 
                  WHERE department_id = 30)
ORDER BY salary; 
--서브쿼리 결과
--11000 => 비교
--3100
--2900
--2800
--2600
--2500

-- 30번 부서의 최소 salary(2500)보다 작은 정보
SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE salary < ALL(SELECT salary -- 최소 salary(2500)
                      FROM employees 
                  WHERE department_id = 30)
ORDER BY salary; 
-- 서브쿼리 결과
--11000
--3100
--2900
--2800
--2600
--2500 => 비교

-- 메인쿼리 결과
--132   Olson       ST_CLERK   2100   50
--136   Philtanker   ST_CLERK   2200   50
--128   Markle       ST_CLERK   2200   50
--135   Gee           ST_CLERK   2400   50
--127   Landry       ST_CLERK   2400   50

-- 4) EXISTS : 서브쿼리에 결과값이 하나이상 존재하면 조건식이 모두 TRUE, 존재하지 않으면 모두 false
-- EXISTS가 false이면 검색결과가 없다.

SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE EXISTS(SELECT department_name  -- 300번 부서가 존재하지 않으므로 false를 반환
                FROM departments 
               WHERE department_id = 300)
ORDER BY salary; 

-- EXISTS가 true이면 검색결과가 조회(사원테이블의 전건)
SELECT employee_id
     , last_name
     , job_id
     , salary
     , department_id
  FROM employees
 WHERE EXISTS(SELECT department_name  -- 20번 부서가 존재하므로 true를 반환
                FROM departments 
               WHERE department_id = 20)
ORDER BY salary; 

/* 서브쿼리 => 매우 중요
 1. WHERE 절에서 사용하는 서브쿼리 .. 조건비교
 2. FROM 절에서 사용하는 서브쿼리(=인라인뷰) .. 테이블 대용
 3. SELECT 절에서 사용하는 서브쿼리(=스칼라 서브쿼리) .. 컬럼 대용
 */ 
-- 5)스칼라 서브쿼리 : SELECT 절에서 사용하는 서브쿼리
-- 반드시 한 컬럼만 반환하는 서브쿼리이다. 만약 한컬럼이 여러개의 값을 가지면 오류가 발생한다.
SELECT employee_id
     , last_name
     , job_id
     , (SELECT TRUNC(AVG(salary),0) FROM employees) AS "평균급여"
     , department_id
     , (SELECT d.department_name
          FROM departments d, employees e
         WHERE d.department_id = e.department_id
           AND d.department_id = 10) AS "부서명"
  FROM employees e;

-- 6-1) 인라인뷰 : FROM절에서 사용하는 서브쿼리
-- 특정 테이블 전체가 아닌, SELECT문을 통해 일부 데이터를 추출한 후 별칭을 주어 사용
-- 10번 부서의 사번, 이름, 직무, 급여, 부서코드, 부서명 가져오기

 SELECT e.employee_id                   
     , e.last_name              
     , e.job_id              
     , e.salary              
     , d.department_id  
     , d.department_name
  FROM employees e            
     , departments d
 WHERE e.department_id = d.department_id
   AND e.department_id = 10;  
-- 200   Whalen   AD_ASST   4400   10   Administration 

SELECT e.employee_id                   
     , e.last_name              
     , e.job_id              
     , e.salary              
     , d.department_id  
     , d.department_name
 FROM (SELECT * FROM employees
        WHERE department_id = 10) e
    , (SELECT * FROM departments) d
 WHERE e.department_id = d.department_id;
 
-- 6-2). with절 : 인라인뷰를 가독성있게 사용할 경우
/* 테이블내 데이터 규모가 크거나, 현재 작업에 불필요한 열이 너무 많아, 행과 열만 사용하고자 할 때 사용
 * - 문법 
 *   WITH
 *   별칭1 AS (SELECT문),
 *   별칭2 AS (SELECT문)
 *   메인쿼리..
 *      FROM 별칭1,별칭2
 * 
 * - 실행 => WITH~끝 
 */ 
  WITH
     e AS (SELECT * FROM employees
        WHERE department_id = 10),
     d AS (SELECT * FROM departments)   
SELECT e.employee_id                   
     , e.last_name              
     , e.job_id              
     , e.salary              
     , d.department_id  
     , d.department_name
 FROM  e, d
 WHERE e.department_id = d.department_id;