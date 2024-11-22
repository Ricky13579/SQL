-- 3일차
/* 
 * 숫자함수 => 중요
 * ROUND : 지정한 숫자의 특정 위치에서 반올림한 값을 반환
 * TRUNC : 지정한 숫자의 특정 위치에서 버림한 값을 반환
 * CEIL : 지정한 숫자와 가까운 큰 정수 반환
 * FLOOR : 지정한 숫자와 가까운 작은 정수 반환
 * MOD : 숫자를 나눈 나머지 값을 구하는 MOD 함수
 */
-- ROUND(숫자, 반올림위치),    반올림위치가 생략시 0이 생략됨
-- 반올림위치 0 : 소수점 첫째자리
-- 반올림위치 -1 : 자연수 첫째자리가 5 이상이면 반올림을 하고 0으로 채우고, 5보다 작으면 0으로 채운다.
-- 실습6-11.
SELECT ROUND(1234.5678) AS ROUND
     , ROUND(1234.5678, 0) AS ROUND_0
     , ROUND(1234.5678, 1) AS ROUND_1
     , ROUND(1234.5678, 2) AS ROUND_2
     , ROUND(1234.5678, -1) AS ROUND_M1
     , ROUND(1235.5678, -1) AS ROUND_M1
     , ROUND(1234.5678, -2) AS ROUND_M2
  FROM dual;

-- TRUNC(숫자 버림위치)
SELECT TRUNC(1234.5678) AS TRUNC
     , TRUNC(1234.5678, 0) AS TRUNC_0
     , TRUNC(1234.5678, 1) AS TRUNC_1
     , TRUNC(1234.5678, 2) AS TRUNC_2
     , TRUNC(1234.5678, -1) AS TRUNC_M1
     , TRUNC(1235.5678, -1) AS TRUNC_M2
     , TRUNC(1234.5678, -2) AS TRUNC_M3
     , TRUNC(1234.5678, -2) AS TRUNC_M4
  FROM dual;
  
-- CEIL : 지정한 숫자와 가까운 큰 정수 반환
-- FLOOR : 지정한 숫자와 가까운 작은 정수 반환
SELECT CEIL(3.14)       -- 3과 4 사이에서 큰 정수
     , FLOOR(3.14)      -- 3과 4 사이에서 작은 정수
     , CEIL(-3.14)      -- -3과 -4 사이에서 큰 정수
     , FLOOR(-3.14)     -- -3과 -4 사이에서 작은 정수
  FROM dual;

-- MOD : 숫자를 나눈 나머지 값을 구하는 MOD 함수
SELECT MOD(15, 6)
     , MOD(10, 2)
     , MOD(11, 2)
  FROM dual;

/* 실습 6-12.
   날짜연산, sysdate : 현재일
*/
SELECT sysdate-1 어제
     , sysdate 오늘
     , sysdate+1 내일
  FROM dual;

/*
 * 6-13. 날짜함수
 * - 두 날짜간의 개월수 차이를 구하는 MONTHS_BETWEEN 함수
 * - 형식 : MONTHS_BETWEEN(날짜, 날짜)
 */
SELECT sysdate 오늘
     , MONTHS_BETWEEN(sysdate, '2024-11-22') "개강후 몇 개월"
     , ROUND(MONTHS_BETWEEN(sysdate, '2025-05-12'), 0) "종강까지 몇 개월"
     , ROUND(to_date('2025-05-12') - sysdate) "수업일수"
     , ROUND(to_date('2025-05-12') - to_date('2024-10-31')) "전체 수업일수"
  FROM dual;

/*
 * 6-14. 날짜함수
 * - 몇 개월 이후 날짜를 더하는 ADD_MONTHS 함수
 * - 형식 : ADD_MONTHS(날짜, 더할 개월 수)
 */
 SELECT ADD_MONTHS(sysdate, 3) "3개월 후"
  FROM dual;
 
/* 실습 6-15.
 * 날짜의 ROUND 반올림 함수, TRUNC 버림 함수
 * 형식 : TRUNC(date, format)
 * TRUNC => format이 'MONTH'인 경우, 달을 기준으로 자른다. 이번 달 1일
 * ROUND => format이 'MONTH'인 경우, 일을 기준으로 16보다 작으면 이번 달 1일, 16 이상이면 다음달 1일
 */
-- 사원테이블에서 사번, 입사일, T_입사일, R_입사일, 근무개월수, R_근무개월수, T_근무개월수를 구한다.
-- 입사일 오름차순
SELECT employee_id 사번
     , hire_date 입사일
     , TRUNC(hire_date, 'MONTH') T_입사일
     , ROUND(hire_date, 'MONTH') R_입사일
     , MONTHS_BETWEEN(sysdate, hire_date) 근무개월수
     , ROUND(MONTHS_BETWEEN(sysdate, hire_date),0) R_근무개월수
     , TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) T_근무개월수
  FROM employees
  ORDER BY hire_date;

/*
 * - NEXT_DAY : 돌아오는 요일의 날짜 반환 => NEXT_DAY([날짜 데이터], [요일문자])
 *              요일 대신 숫자가 올 수 있다. 1:일요일, 2:월요일
 * - LAST_DAY : 달의 마지막 날짜 반환 => LAST_DAY([날짜 데이터])
 */
 
SELECT sysdate "오늘"
     , NEXT_DAY(sysdate, 1) "일요일"
     , NEXT_DAY(sysdate, '일요일') "일요일"
     , NEXT_DAY(sysdate, '월요일') "월요일"
     , NEXT_DAY(sysdate, '화요일') "화요일"
     , NEXT_DAY(sysdate, '수요일') "수요일"
     , NEXT_DAY(sysdate, '목요일') "목요일"
     , NEXT_DAY(sysdate, '금요일') "금요일"
     , NEXT_DAY(sysdate, '토요일') "토요일"
  FROM dual;

-- 실습 6-16. 사원테이블에서 사번, 입사일, 입사한 달의 마지막날 조회
SELECT employee_id
     , hire_date
     , LAST_DAY(hire_Date) "입사일 마지막 날"
  FROM employees;
  
/*
 * TO_CHAR : 숫자 또는 날짜 -> 문자 데이터로 변환
 * TO_NUMBER : 문자 -> 숫자 데이터로 변환
 * TO_DATE : 문자 -> 날짜 데이터로 변환
 */
 
/*
1. TO_CHAR
- 날짜형 혹은 숫자형을 문자형으로 변환한다.
- 형식 : TO_CHAR(날짜데이터, '출력형식')
- 날짜 출력 형식
  종류   의미
  YYYY  년도표현(4자리)
  YY    년도표현(2자리)
  MM    월을 숫자로 표현
  MON   월을 알파벳으로 표현
  DD    일을 숫자로 표햔
  DAY   요일 표현
  DY    요일을 약어로 표현
  W     몇 번째 주
  CC    세기
 */ 
-- 1. TO_CHAR
-- 날짜형 혹은 숫자형을 문자형으로 변환한다.
-- 형식 : TO_CHAR(날짜데이터, '출력형식')

SELECT sysdate 오늘
     , TO_CHAR(sysdate, 'YY/MM/DD DAY') 오늘날짜
     , TO_CHAR(sysdate, 'YY/MM/DD (DAY)') 오늘날짜
     , TO_CHAR(sysdate, 'YY/MM/DD DY') 오늘날짜
     , TO_CHAR(sysdate, 'YY/MM/DD (DY)') 오늘날짜
  FROM dual;

-- 시간 표현
-- 오전 -> AM | 오후 -> PM
-- 12시간 -> HH:MI:SS
-- 24시간 -> HH24:MI:SS

SELECT sysdate 오늘
     , TO_CHAR(sysdate, 'YY/MM/DD (DY) HH:MI:SS') 날짜1
     , TO_CHAR(sysdate, 'YY/MM/DD (DY) HH:MI:SS PM') 날짜1
  FROM dual;

/*
-- 1-2. TO_CHAR(숫자형) -> 문자형으로 변환한다.
-- 형식 : TO_CHAR(숫자, '출력형식')
- L : 각 지역별 통화기호를 앞에 표시 예) 한국: -- 도구-환경설정 -> 검색(돋보기) -> NLS창에 통화 설정
- 특수문자 : ㄹ+한자키
- , : 천단위 자리 구분을 표시
- . : 소수점을 표시
- 9 : 자리수를 나타내며, 자리수가 안 맞아도 0으로 채우지 않는다.
- 0 : 자리수를 나타내며, 자리수가 맞지 않으면 나머지 공간을 0으로 채운다.
 */
SELECT employee_id 사번
     , salary
     , TO_CHAR(salary, 'L9,999,999') L9
     , TO_CHAR(salary, 'L0,009,999') L0
     , TO_CHAR(salary, '$9,999,999') "$9"
     , TO_CHAR(salary, '$0,009,999') "$0"
  FROM employees;

/*
 * 2. TO_DATE : 문자 -> 날짜 데이터로 변환
 * - 형식 : TO_DATE('문자', '날짜 format')
 */ 
-- 실습 6-17. 입사일이 03/06/17인 사원의 사번, 입사일 조회
SELECT employee_id 사번
     , hire_Date 입사일
  FROM employees
 WHERE hire_Date = '03/06/17'; -- 자료형이 동일해야 비교 가능, 둘다 DATE

SELECT employee_id 사번
     , hire_date 입사일
     , TO_CHAR(hire_date,'YYYY/MM/DD (DY)') "TO_CHAR 입사일"
  FROM employees
 WHERE hire_date = TO_DATE('03/06/17', 'YY/MM/DD');

/*
 * TO_NUMBER
 * - 문자형을 숫자형으로 바꾼다.
 */
SELECT '100,000' - '50,000'
  FROM dual; -- 오류 : 문자열은 산술 불가
 
SELECT TO_NUMBER('100,000', '999,999') - TO_NUMBER('50,000', '999,999') 결과
  FROM dual; 

/*
 * 1. NVL 함수 => 매우 중요
 * - NULL : 미확정, 값이 정해져있지 않아 알 수 없는 값을 의미하며, 연산, 대입, 비교 불가
 *          연산시 관계 컬럼값도 null로 바뀐다
 * - NVL : 값이 NULL일 경우 연산, 대입, 비교가 불가함으로 NVL로 대체
 *          NULL을 0이나 다른 값으로 변환
 *          문법 : NVL(컬럼값, 초기값)
 *                  단 두개의 값은 반드시 데이터 타입이 일치해야 함
 */
-- 1. 사원테이블의 last_name, salary, salary*12+commission_pct 연봉 , 커미션 조회
-- 급여 >= 10000
SELECT employee_id 사번
     , last_name
     , salary 급여
     , commission_pct "커미션"
     , (salary * 12 + commission_pct) 연봉
     , (salary * 12 + nvl(commission_pct,0)) "nvl 연봉" -- NVL 함수 : commission_pct가 null이면 0으로 치환
  FROM employees
 WHERE salary >= 10000
 ORDER BY "nvl 연봉";
 
-- 2. LOCATIONS 테이블에서 location_id, city, state_province 조회
-- 단 state_province가 null이 아닌 경우 조회
SELECT location_id
     , city
     , state_province
  FROM locations
 WHERE state_province is not null;

-- 2. LOCATIONS 테이블에서 location_id, city, state_province 조회
-- 단 state_province가 null이면 '미정 주'로 조회
SELECT location_id
     , city
     , nvl(state_province, '미정 주') "nvl"
  FROM locations;

/*
 * NVL2 함수
 * 형식 : NVL2(expr1, expr2, expr3)
 * - expr1이 null이면 expr3를 반환하고, null이 아니면 expr2를 반환
 */
-- 사원테이블의 last_name, salary, salary*12+commission_pct 연봉 , 커미션 조회
-- 급여 >= 10000
SELECT last_name
     , salary
     , (salary * 12 + commission_pct) 연봉
     , (salary * 12 + nvl(commission_pct,0)) "nvl 연봉"
     , (salary * 12 + nvl2(commission_pct, commission_pct, 0)) "nvl2 연봉"
     , commission_pct
  FROM employees
 WHERE salary >= 10000;
  
/*
 * 3. NULLIF 함수
 * - 형식 : NULLIF(expr1, expr2)
 * - 두 표현식을 비교하여 동일하면 null을 반환하고, 동일하지 않으면 첫번째 표현식을 반환
 */
SELECT NULLIF('A', 'A')
     , NULLIF('A', 'B')
  FROM dual;
  
/*
 * 4. COALESCE
 * - 형식 : COALESCE(expr_1, expr_2, ...expr_n)
 * - 인수중에서 null이 아닌 첫번째 인수를 반환하는 함수
 */
-- 사원테이블의 last_name, salary, salary*12+commission_pct 연봉 , 커미션 조회
-- 급여 >= 10000
SELECT last_name
     , salary
     , (salary * 12 + commission_pct) 연봉
     , (salary * 12 + nvl(commission_pct,0)) "nvl 연봉"
     , (salary * 12 + nvl2(commission_pct, commission_pct, 0)) "nvl2 연봉"
     , (salary * 12 + COALESCE(commission_pct, 0)) "COALESCE 연봉"
  FROM employees
 WHERE salary >= 10000;

/*
 * DECODE 함수 : 자바의 Switch Case와 동일
 * - 조건에 따라 다양한 선택이 가능
 * - 형식 : DECODE(표현식, 조건1, 결과1,
 *                       조건2, 결과2,
 *                       조건3, 결과3...
 *                       기본결과n);
 */
-- 사번, 이름, 직무코드, 급여, 수당(decode로 수당 출력)
SELECT employee_id 사번
     , first_name || ' ' || last_name 이름
     , job_id 직무코드
     , salary 급여
     , DECODE (job_id, 
                'AD_PRES', salary*1.1,
                'AD_VP',   salary*1.2,
                'IT_PROG', salary*1.3,
                'FI_MGR',  salary*1.4,
                salary*1.5) 수당
  FROM employees;

/*
 * CASE문 : 자바의 if else와 동일
 * - 형식 : CASE
 *              WHEN 표현식 조건1 THEN 결과1
 *              WHEN 표현식 조건2 THEN 결과2
 *              WHEN 표현식 조건3 THEN 결과3...
 *              ELSE 결과n
 *         END
 */
-- CASE문 적용
SELECT employee_id 사번
     , first_name || ' ' || last_name 이름
     , job_id 직무코드
     , salary 급여
     , CASE job_id 
            WHEN 'AD_PRES' THEN salary * 1.1
            WHEN 'AD_VP' THEN salary * 1.2
            WHEN 'IT_PROG' THEN salary * 1.3
            WHEN 'FI_MGR' THEN salary * 1.4
            ELSE salary*1.5
        END AS "수당"
  FROM employees;

-- 사번, 이름, 직무코드, 급여, 커미션, (case 적용)comm_text 조회
-- 커미션이 null이면 '해당사항 없음', 0이면 '수당 없음', 0보다 크면 연봉
SELECT employee_id
     , first_name || ' ' || last_name 이름
     , salary
     , commission_pct
     , CASE  
            WHEN commission_pct is null then '해당사항 없음'
            WHEN commission_pct = 0 then '수당 없음'
            ELSE '연봉 : '|| (salary * 12 + commission_pct)
        END comm_text
  FROM employees;