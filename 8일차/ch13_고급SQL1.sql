/* 1. 그룹화와 관련된 여러가지 함수 ROLLUP, CUBE, GROUPING SETS 함수
 * => GROUP BY 절에 지정할 수 있는 함수
 * [형식]
 * SELECT 컬럼1, 컬럼2, 그룹함수... 
 *   FROM 테이블명 
 *  WHERE 절
 *  GROUP BY CUBE(그룹화할 컬럼1. 그룹화할 컬럼2...);
 * 
 * SELECT 컬럼1, 컬럼2, 그룹함수...
 *   FROM 테이블명
 *  WHERE절
 *  GROUP BY GROUPING SETS(그룹화할 컬럼1, 컬럼2...)
 */
-- HR 계정에서 실행
-- 1. 기존 GROUP BY절만 사용한 그룹화
-- 부서별 직무별 그룹함수
SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID , JOB_ID 
 ORDER BY DEPARTMENT_ID , JOB_ID ;
     
-- 2. ROLLUP 함수를 적용한 그룹화
-- ROLLUP 함수는 명시한 열에 대해 소그룹별 결과를 출력하고, 마지막에 최종결과를 출력한다.
-- ROLLUP 함수에 명시한 열에 한하여 결과가 출력되며, ROLLUP 함수에는 그룹함수를 지정할 수 없다.
SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
  FROM EMPLOYEES
 GROUP BY ROLLUP(DEPARTMENT_ID , JOB_ID)
 ORDER BY DEPARTMENT_ID , JOB_ID ;
 
-- 10	AD_ASST	1	4400	4400	4400
-- 10	소계		1	4400	4400	4400
-- 20	MK_MAN	1	13000	13000	13000
-- 20	MK_REP	1	6000	6000	6000
-- 20	소계		2	13000	19000	9500
-- 30	PU_CLERK	5	3100	13900	2780
-- 30	PU_MAN	1	11000	11000	11000
-- 30	소계		6	11000	24900	4150
-- 40	HR_REP	1	6500	6500	6500
-- 40	소계		1	6500	6500	6500
-- 50	SH_CLERK	20	4200	64300	3215
-- 50	ST_CLERK	20	3600	55700	2785
-- 50	ST_MAN	5	8200	36400	7280
-- 50	소계		45	8200	156400	3475.56
-- 60	IT_PROG	5	9000	28800	5760
-- 60	소계		5	9000	28800	5760
-- 70	PR_REP	1	10000	10000	10000
-- 70	소계		1	10000	10000	10000
-- 80	SA_MAN	5	14000	61000	12200
-- 80	SA_REP	29	11500	243500	8396.55
-- 80	소계		34	14000	304500	8955.88
-- 90	AD_PRES	1	24000	24000	24000
-- 90	AD_VP	2	17000	34000	17000
-- 90	소계		3	24000	58000	19333.33
-- 100	FI_ACCOUNT	5	9000	39600	7920
-- 100	FI_MGR	1	12008	12008	12008
-- 100	소계		6	12008	51608	8601.33
-- 110	AC_ACCOUNT	1	8300	8300	8300
-- 110	AC_MGR	1	12008	12008	12008
-- 110	소계		2	12008	20308	10154
--	SA_REP		1	7000	7000	7000
--	소계			1	7000	7000	7000
--	총계			107	24000	691416	6461.83

-- 3. CUBE 함수를 적용한 그룹화
-- ROLLUP 결과와 동일하게 출력되며, 그 아래에 부서와 상관없이 직책별 결과가 함께 출력된다.
-- CUBE 함수는 지정한 모든 열에서 가능한 조합의 결과를 모두 출력한다.
SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
  FROM EMPLOYEES
 GROUP BY CUBE(DEPARTMENT_ID , JOB_ID)
 ORDER BY DEPARTMENT_ID , JOB_ID ;
 
-- 4. GROUPING SETS
-- GROUPING SETS 함수를 사용하여 컬럼별로 그룹으로 묶어 출력하기
-- 지정한 모든 열을 각각 대그룹으로 처리하여 출력
-- CUBE와 같으나 소계가 없음
SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
  FROM EMPLOYEES
 GROUP BY GROUPING SETS (DEPARTMENT_ID , JOB_ID)
 ORDER BY DEPARTMENT_ID , JOB_ID ;
 
-- 5. GROUPING 함수 : 그룹화(0), 비그룹화(1), NULL(1)
-- 각 한 컬럼씩만 GROUPING 할 수 있다.
-- 부서와 직무의 그룹화 결과 여부를 GROUPING 함수로 확인하기
SELECT department_id
     , job_id
     , COUNT(*)
     , max(salary)
     , sum(salary)
     , round(avg(salary), 2)
     , GROUPING(DEPARTMENT_ID)
     , GROUPING(JOB_ID)
  FROM EMPLOYEES
 GROUP BY CUBE(DEPARTMENT_ID , JOB_ID)
 ORDER BY DEPARTMENT_ID , JOB_ID ;
 
-- 6. LISTAGG 함수 : LISTAGG ~ WITHIN GROUP => 그룹에 속해 있는 데이터를 가로로 나열할 때 사용
-- 부서별 사원 이름을 나열히 나열해서 출력하기
SELECT department_id
     , LISTAGG(LAST_NAME, ', ')
     	WITHIN GROUP(ORDER BY salary DESC) AS last_name
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
 ORDER BY DEPARTMENT_ID;