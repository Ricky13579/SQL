/* 1. 분석함수(중요)
- 테이블에 있는 데이터를 특정용도로 분석하여 결과를 반환하는 함수
- PARTITION BY : 계산 대상을 그룹으로 정한다.
- OVER : 분석함수임을 나타내는 키워드
- 분석함수는 그룹별 계산결과를 각 행마다 보여준다.
   분석함수는 그룹함수와 그룹단위로 값을 계산한다는 점에서 유사하지만,
            그룹마다가 아니라 결과 SET의 각 행마다 집계결과를 보여준다.
*/
-- HR 계정에서 실행
-- 각각의 동일 부서의 급여합계
SELECT department_id
     , employee_id
     , salary
     , sum(salary) OVER(Partition BY department_id) as sum_sal
  FROM employees
 ORDER BY department_id;

-- PIVOT 함수를 사용하여 직책별 부서별 최고급여를 2차원 표형태로 출력하기
SELECT *
  FROM (SELECT department_id, job_id, salary
  		  FROM EMPLOYEES)
  PIVOT(Max(salary)
  			FOR department_id in(10, 20, 30)
  		)
  ORDER BY job_id;		
-- AD_ASST		4400		(10번부서)	
-- MK_MAN		13000	    (20번부서)
-- MK_REP		6000		(20번부서)
-- PU_CLERK		3100		(30번부서)
-- PU_MAN		11000		(30번부서)
		  
SELECT job_id
     , department_id
     , max(salary)
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID  < 40
 GROUP BY JOB_ID , DEPARTMENT_ID 
 ORDER BY DEPARTMENT_ID ;