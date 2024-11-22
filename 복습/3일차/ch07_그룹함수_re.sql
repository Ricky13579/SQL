-- 커미션 합계(없으면 0)
SELECT SUM(nvl(commission_pct, 0)) "커미션 합계"
  FROM employees;
  
-- 커미션 평균(없으면 0.1, 소수점 셋째자리에서 반올림)
SELECT ROUND(AVG(nvl(commission_pct, 0.1)), 2) "커미션 평균 셋째짜리"
  FROM employees;

-- 커미션 평균(없으면 0.1, 소수점 둘째자리에서 반올림)
SELECT ROUND(AVG(nvl(commission_pct, 0.1)), 1) "커미션 평균 둘째짜리"
  FROM employees;

-- 최대커미션, 최소커미션(null 제외)
SELECT MAX(commission_pct) "최대 커미션"
     , MIN(commission_pct) "최소 커미션"
  FROM employees
 WHERE commission_pct is not null;

-- 직무테이블의 직무개수
SELECT count(job_id) "직무테이블 직무개수"
  FROM jobs;

-- 사원테이블에서 직무개수
SELECT count(job_id) "사원테이블 직무개수"
  FROM employees; -- 107

-- 사원테이블에서 직무개수(중복 제거)
SELECT count(distinct job_id) "중복 제거 직무개수"
  FROM employees; -- 19

-- 사원테이블에서 커미션 합계, 커미션 평균(소수점 2째자리), 최대 커미션, 최소 커미션, 직무개수를 조회
-- 커미션이 없는 사람은 제외
SELECT sum(commission_pct) "커미션 합계"
     , round(avg(commission_pct),2) "커미션 평균"
     , max(commission_pct) "최대 커미션"
     , min(commission_pct) "최소 커미션"
     , count(distinct job_id) "직무개수"
  FROM employees
 WHERE commission_pct is not null;