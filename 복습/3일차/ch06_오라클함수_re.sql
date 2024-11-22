-- ROUND
SELECT ROUND(NVL(commission_pct, 0),1) 커미션
  FROM employees;

-- TRUNC
SELECT TRUNC(75659.65465344) 버림
     , TRUNC(75659.65465344, 0) "소수점 첫째자리 버림"
     , TRUNC(75659.65465344, 1) "소수점 둘째자리 버림"
     , TRUNC(75659.65465344, -1) "자연수 1의 자리 버림"
  FROM dual;
  
-- CEIL : 가까운 큰 정수
-- FLOOR : 가까운 작은 정수
SELECT CEIL(9.8)
     , FLOOR(9.8)
     , CEIL(-9.8)
     , FLOOR(-9.8)
  FROM dual;

-- MOD
SELECT MOD(10, 3)
     , MOD(9, 8)
     , MOD(89, 21)
  FROM dual;

-- 올해 크리스마스까지 남은 일수
SELECT TRUNC(to_Date('2024-12-25') - sysdate)||'일' "카운트다운"
  FROM dual;

-- 이 회사는 2023년 1월 5일에 망해서 문을 닫았다.
-- 그럼 이 회사에 입사한 사람들이 망할 때까지 한 명도 이직을 안 했다고 가정하면
-- 이 사람들은 몇 개월간 근무했을까?
-- 사번, 근무개월수(trunc로 자연수만 조회), 입사일을 조회
SELECT employee_id
     , trunc(MONTHS_BETWEEN('2023-01-05', hire_Date)) "근무개월수"
     , hire_Date 입사일
  FROM employees;

-- 개강일 날짜
SELECT to_char(to_date('2024-10-31'), 'YYYY-MM-DD DAY') 개강일
     , to_char(to_date('2024-10-31'), 'YYYY-MM-DD DY') 개강일
     , to_char(to_date('2024-10-31'), 'YYYY-MM-DD (DAY)') 개강일
     , to_char(to_date('2024-10-31'), 'YYYY-MM-DD (DY)') 개강일
  FROM dual;

SELECT sysdate 오늘
     , TO_CHAR(sysdate, 'YY/MM/DD (DY) HH:MI:SS') 날짜1
     , TO_CHAR(sysdate, 'YY/MM/DD (DY) HH:MI:SS PM') 날짜1
  FROM dual;

-- 사번, 상사번호 조회
-- 사장의 상사번호는 0
SELECT employee_id 사번
     , nvl(manager_id, 0) 상사번호
  FROM employees;

-- 사번, 급여, 커미션, 연봉으로 조회하되 커미션은 null이면 0으로 아니면 1로 조회
-- 연봉도 마찬가지(nvl2)
SELECT employee_id 사번
     , salary 급여
     , nvl2(commission_pct, 1, 0) 커미션
     , salary * 12 + nvl2(commission_pct, 1, 0) 연봉
  FROM employees;

SELECT nullif('에스파', '아이브')
     , nullif('카리나', '카리나')
  FROM dual;
  
/* DECODE 함수, CASE문
 * 사원테이블의 부서코드가 10~60인 경우 부서ID와 '부서명'출력
 * 그 외는 '부서미정'으로 출력 부서코드는 정렬
 * 단, 부서ID는 중복X, 부서코드는 null이면 제외
 */
SELECT distinct department_id 부서번호
     , DECODE(department_id, 
            10, '부서명',
            20, '부서명',
            30, '부서명',
            40, '부서명',
            50, '부서명',
            60, '부서명',
            '부서미정') as 부서
  FROM employees
 WHERE department_id is not null
 ORDER BY department_id;

SELECT distinct department_id 부서번호
     , CASE department_id 
            WHEN 10 THEN '부서명'
            WHEN 20 THEN '부서명'
            WHEN 30 THEN '부서명'
            WHEN 40 THEN '부서명'
            WHEN 50 THEN '부서명'
            WHEN 60 THEN '부서명'
            ELSE '부서미정'
        END as 부서
  FROM employees
 WHERE department_id is not null
 ORDER BY department_id;

SELECT distinct department_id 부서번호
     , CASE 
            WHEN department_id = 10 THEN '부서명'
            WHEN department_id = 20 THEN '부서명'
            WHEN department_id = 30 THEN '부서명'
            WHEN department_id = 40 THEN '부서명'
            WHEN department_id = 50 THEN '부서명'
            WHEN department_id = 60 THEN '부서명'
            ELSE '부서미정'
        END as 부서
  FROM employees
 WHERE department_id is not null
 ORDER BY department_id;

SELECT distinct department_id 부서번호
     , CASE
            WHEN department_id >= 10 
            and department_id <= 60 
            THEN '부서명'
            ELSE '부서미정'
        END as 부서
  FROM employees
 WHERE department_id is not null
 ORDER BY department_id;

-- 미국은 주가 많다. 그래서 지역번호도 다양한데, 전화번호를 쓸 떄 맨 앞에 이 지역번호를 쓴다.
-- 전화번호 중에서 지역번호(앞 세글자)를 이용해서 어느 주의 지역번호인지 조회
-- 사번, 이름, 지역번호 조회
-- 515 - 캔자스
-- 603 - 뉴햄프셔
-- 650 - 캘리포니아
-- 나머지는 '모르겠음'(CASE 사용)
SELECT employee_id 사번
     , first_name || '-' || last_name 이름
     , substr(phone_number, 1, 3) 지역번호
     , CASE substr(phone_number, 1, 3)
       WHEN '515' THEN '캔자스'
       WHEN '603' THEN '뉴햄프셔'
       WHEN '650' THEN '캘리포니아'
       ELSE '모르겠음'
       END as 지역
  FROM employees;