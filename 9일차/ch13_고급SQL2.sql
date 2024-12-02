/* 2. 순위함수 (중요)
    - RANK() 함수 - 순위를 부여하는 함수로 동일 순위 처리가 가능하다. 동일 등수가 순위에 영향을 미친다.
    (중복 순위 다음 순서는 건너뜀 - 1,2,2,2,5)
    
    - DENSE_RANK() 함수 - RANK() 함수와 동일하나, 동일 등수가 순위에 영향을 미치지 않는다.
    (중복 순위 다음 순서는 건너뛰지 않음 - 1,2,2,2,3)
    
    - ROW_NUMBER() 함수 - 특정순위로 일련번호를 제공하는 함수로, 동일 순위 처리가 불가능하다.
    (중복 순위없이 유일값 - 1,2,3,4)
    
    - 순위함수 사용시 반드시 ORDER BY절 기술
    - NTILE(분류)함수는 쿼리의 결과를 N개의 그룹으로 분류하는 기능을 제공한다.
    - NTILE(분류숫자)함수는 지정한 분류 숫자만큼의 그룹으로 분류하는 기능을 제공한다.
 */
-- 2-1. 순위함수 RANK()
-- 급여가 높은 순서로 순위 구하기
SELECT department_id
     , employee_id
     , salary
     , RANK() OVER(ORDER BY salary DESC) 순위
  FROM employees;

-- 2-2. 순위함수 비교
SELECT department_id
     , employee_id
     , salary
     , RANK() OVER(ORDER BY salary DESC) RANK
     , DENSE_RANK() OVER(ORDER BY salary DESC) D_RANK
     , ROW_NUMBER() OVER(ORDER BY salary DESC) R_RANK
  FROM employees;

-- 2-3. 순위함수 NTILE(분류)
SELECT employee_id
     , NTILE(2) OVER(ORDER BY employee_id) group2 -- 전체를 2등분하여 1, 2로 표현
     , NTILE(3) OVER(ORDER BY employee_id) group3 -- 전체를 3등분하여 1, 2, 3로 표현
     , NTILE(4) OVER(ORDER BY employee_id) group4 -- 전체를 4등분하여 1, 2, 3, 4로 표현
  FROM employees;

/* 3. 윈도우 함수
- 분석함수 중에서 윈도우절(WINDOWING)을 사용하는 함수다.
- 윈도우절을 사용하면 PARTITION BY절에 명시된 그룹을 좀 더 세부적으로 그룹핑할 수 있다.
- 윈도우절은 분석함수 중에서 일부(AVG, SUM, MAX, MIN, COUNT)만 사용할 수 있다.
- ROWS : 물리적인 ROW단위로 행집합을 지정한다.
- RNAGE : 물리적인 상대번지로 행집합을 지정한다.
 */
-- 3-1. ROWS 사용예제
-- 부서별로 이전 ROW의 급여와 현재 ROW의 급여합계를 출력 
-- ROWS 2 PRECEDING -> (현재 + 이전 + 그 이전) 급여합계

 SELECT employee_id
      , last_name
      , department_id
      , salary
      , sum(salary) OVER(Partition BY department_id
                             ORDER BY employee_id
                             ROWS 2 PRECEDING) as pre_sum
  FROM employees;

-- 3-2. RANGE 사용예쩨 => 중요
-- 영업정보 시스템에서 분석화면에 전월비교, 전년비교, 분기별 합계, 분기별 평균
-- PRECEDING : 이전 / FOLLOWING : 이후
-- Scott_03에서 실행 - 전체 블록잡아서 실행
WITH test AS(
    SELECT '202401' yyyymm, 100 amt FROM dual
    UNION ALL SELECT '202402' yyyymm, 200 amt FROM dual
    UNION ALL SELECT '202403' yyyymm, 300 amt FROM dual
    UNION ALL SELECT '202404' yyyymm, 400 amt FROM dual
    UNION ALL SELECT '202405' yyyymm, 500 amt FROM dual
    UNION ALL SELECT '202406' yyyymm, 600 amt FROM dual
--    UNION ALL SELECT '202407' yyyymm, 700 amt FROM dual => 0으로 계산
    UNION ALL SELECT '202408' yyyymm, 800 amt FROM dual
    UNION ALL SELECT '202409' yyyymm, 900 amt FROM dual
    UNION ALL SELECT '202410' yyyymm, 1000 amt FROM dual
    UNION ALL SELECT '202411' yyyymm, 1100 amt FROM dual
    UNION ALL SELECT '202412' yyyymm, 1200 amt FROM dual
)
SELECT yyyymm
     , amt
     , sum(amt) OVER(ORDER BY to_date(yyyymm, 'yyyymm')
                RANGE BETWEEN INTERVAL '3' MONTH PRECEDING -- 이전 3개월(현재달은 미포함)
                          AND INTERVAL '1' MONTH PRECEDING) amp_pre3
     , sum(amt) OVER(ORDER BY to_date(yyyymm, 'yyyymm')
                RANGE BETWEEN INTERVAL '1' MONTH FOLLOWING -- 이후 3개월(현재달은 미포함)
                          AND INTERVAL '3' MONTH FOLLOWING) amp_post3
  FROM test;

-- 3. 오라클 DBMS에서 아래 보기처럼 SCOTT 계정의 정보를 출력하시오.(사용자이름, 계정상태, 테이블공간, 생성일자)
-- SYSTEM 계정에서 실행
SELECT username
     , account_status
     , default_tablespace
     , created
  FROM dba_users
 WHERE username = 'SCOTT_04';

