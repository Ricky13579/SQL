/*
 * 7-2. GROUP BY
 * - 특정 컬럼을 기준으로 그룹별로 나눌 때 사용
 * - 형식
 *   SELECT 컬럼1, ...컬럼n, 그룹함수
 *     FROM 테이블명
 *    WHERE 조건
 *    GROUP BY 컬럼1, ...컬럼n
 *    ORDER BY 컬럼명 ASC | DESC;
 *
 * - GROUP BY절 다음에 컬럼의 별칭은 사용할 수 없다.
 * - 그룹함수가 아닌 SELECT 리스트의 모든 일반 컬럼은 GROUP BY절에 반드시 기술해야 한다.(쭝요)
 * - 그러나 반대로 GROUP BY 절에 기술된 컬럼이 반드시 SELECT 리스트에 있어야 하는 건 아니다.
 *   단지 무의미한 결과다
 */
-- 부서별 평균급여
-- SQL Error : ORA-00937 : not a single-group group function => 그룹화해야 함
SELECT department_id "부서번호"
     , ROUND(AVG(salary), 1) "부서별 평균급여"
  FROM employees
  GROUP BY department_id
  ORDER BY department_id;
  
-- 부서별, 직무(job_id)별 최대급여 구하기(소수점 둘째자리), 부서 정렬
SELECT department_id "부서번호"
     , job_id "직무번호"
     , round(avg(salary), 2) "평균급여"
  FROM employees
 GROUP BY job_id, department_id
 ORDER BY department_id;
 
-- 사원테이블에서 직무(job_id)별 총급여, 최대급여 구하기(소수점이하 2째자리), 최소급여, 직무정렬
SELECT job_id
     , SUM(salary) "직무별 총급여"
     , max(salary) "직무별 최대급여"
     , min(salary) "직무별 최소급여"
  FROM employees
 GROUP BY job_id
 ORDER BY job_id;

-- 부서별, 직무별 인원수, 급여 평균, 최대급여(소수점 둘째짜리)
-- 부서, 직무 오름차순(부서는 null 없음)
SELECT department_id "부서번호"
     , job_id "직무번호"
     , count(*) "직무 및 부서별 인원수"
     , round(avg(salary), 2) "평균급여"
     , max(salary) "최대급여"
  FROM employees
 WHERE department_id is not null
 GROUP BY department_id, job_id
 ORDER BY department_id, job_id;
 
 SELECT department_id "부서번호"
     , job_id "직무번호"
     , count(*) "직무 및 부서별 인원수"
     , round(avg(salary), 2) "평균급여"
     , max(salary) "최대급여"
  FROM employees
 WHERE department_id is not null
 GROUP BY department_id, job_id
   HAVING max(salary) >= 10000 -- 그룹함수의 조건은 WHERE가 아닌 HAVING절에 추가
 ORDER BY department_id, job_id;

/*
 * 7-3. 그룹함수 제한 : HAVING절 => 중요
 * - 표시할 그룹을 지정하여 집계정보를 기준으로 필터링
 * - HAVING + 그룹함수 조건절
 */

-- 부서별 최대급여, 총급여(단 총 급여가 15000이상), 부서코드 오름차순
-- 부서코드 없으면 제외
SELECT department_id "부서번호"
     , max(salary) "최대급여"
     , sum(salary) "총급여"
  FROM employees
 WHERE department_id is not null
 GROUP BY department_id
 HAVING sum(salary) >= 15000
 ORDER BY department_id;

-- 직무별 총급여, 평균급여(단 평균급여 5000 이상)
-- 소수점 이하는 무조건 버리기, 직무 오름차순(job_id가 IT를 포함하면 조회되면 안됨)
SELECT job_id 직무코드
     , max(salary) 총급여
     , trunc(Avg(Salary)) 평균급여
  FROM employees
 GROUP By job_id
 HAVING job_id not LIKE '%IT%'
 AND avg(salary) >= 5000
 ORDER BY job_id;