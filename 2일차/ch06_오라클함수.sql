/* ch6. 오라클함수
 * 6-2. 대소문자를 바꿔주는 UPPER, LOWER, INITCAP
 * -- UPPER : 대문자로 변환
 * -- LOWER : 소문자로 변환
 * -- INITCAP : 첫글자만 대문자로, 나머지는 소문자로 변환
 */
-- 사원테이블의 last_name이 'King'일 경우 사번, last_name 조회
SELECT employee_id
     , last_name
  FROM employees
 WHERE last_name = 'King';

-- 사원테이블의 last_name이 'King'일 경우 사번, last_name 조회(INITCAP)
SELECT employee_id
     , INITCAP(last_name) last_name
  FROM employees
 WHERE last_name = 'King';

-- 사원테이블의 last_name이 'King'일 경우 사번, last_name 조회(UPPER)
SELECT employee_id
     , UPPER(last_name) last_name
  FROM employees
 WHERE last_name = 'King';

-- 실습 6-3. 사원테이블의 email이 'TFOX'일 경우 email 조회 -- UPPER(소문자)
SELECT employee_id 
     , email
  FROM employees
 WHERE email = UPPER('tfox');

 /* 실습 6-4.
  * 문자열 길이를 구하는 LENGTH 함수 : 한글 한문자당 1byte
  * 문자열 길이를 구하는 LENGTH 함수 : 한글 한문자당 3byte
  */
-- Dual 테이블 : sys 소유의 테이블로, 오라클에서 제공하는 dummy 테이블, 한 행으로 결과를 출력함, 임시연산, 함수결과 확인용도
-- DUMMY VARCHAR2(1)라는 하나의 컬럼으로 구성되어 있고, 데이터는 'X'값
SELECT * FROM dual; -- X

SELECT LENGTH('안녕') 길이 FROM dual;    -- 2
SELECT LENGTHB('안녕') 길이 FROM dual;   -- 6
SELECT LENGTH('oracle') 길이 FROM dual;  -- 6
SELECT LENGTHB('oracle') 길이 FROM dual; -- 6

SELECT sysdate as 오늘
     , sysdate + 1 as 내일
     , sysdate + 2 as 모레
     , sysdate - 1 as 어제
  FROM dual;
-- 24/11/21	24/11/22	24/11/23	24/11/20

/* 실습 6-5.
 * 문자열 일부를 추출하는 SUBSTR 함수.. 인덱스는 1부터 시작
 * - SUBSTR(문자열데이터, 시작위치, 추출갯수) : 시작위치부터 추출갯수만큼 추출한다.
 * - 시작위치가 양수인 경우 1부터 시작, 음수인 경우 뒤쪽부터 시작
 * - 추출 갯수 생략 시 데이터 끝까지 추출
 */
SELECT job_id
     , SUBSTR(job_id, 1, 2)
     , SUBSTR(job_id, -2, 2)
     , SUBSTR(job_id, -5)
     , SUBSTR(job_id, 5)
  FROM employees
 WHERE job_id = 'AC_ACCOUNT';
-- AC_ACCOUNT	AC	NT	COUNT	CCOUNT

/* 실습 6-6.
 * INSTR - 문자열 내에 특정문자 위치를 찾아주는 함수
 * 형식 - INSTR(대상, 찾을 글자, 시작 위치, 몇 번째 발견)
 *      - 시작위치, 몇번째 발견 생략시 모두 1로 간주
 */
SELECT INSTR('HELLO, ORACLE', 'L') AS instr_1
     , INSTR('HELLO, ORACLE', 'L', 5) AS instr_2
     , INSTR('HELLO, ORACLE', 'L', 2, 2) AS instr_3
  FROM dual;

/* 실습 6-7.
 * REPLACE - 특정문자를 다른 문자로 바꾸는 REPLACE 함수
 * 형식 - REPLACE(문자열 데이터 또는 열이름(필수), [찾는 문자(필수)], [대체할 문자(선택)]
 */

SELECT '010-1111-2222' AS REPLACE_BEFORE
     , REPLACE('010-1111-2222', '-', '') AS REPLACE_1
     , REPLACE('010-1111-2222', '-', '/') AS REPLACE_2
     , REPLACE('010-1111-2222', '-') AS REPLACE_3
  FROM dual;

/* 실습 6-8.
 * 데이터의 빈공간을 특정 문자로 채우는 LPAD, RPAD 함수
 * RPAD(대상, 길이, 채울 문자) => 오른쪽 채우기
 * LPAD(대상, 길이, 채울 문자) => 왼쪽 채우기
 */
SELECT RPAD('971225-', 14, '*') AS 주민번호
  FROM dual;

SELECT RPAD('010-1234-', 13, '*') AS 전화번호
  FROM dual;

/* 실습 6-9.
 * CONCAT - 문자의 값을 연결한다.('||'와 동일)
 */
-- 1. 사원테이블에서 사번, 입사일, 이름
SELECT employee_id
     , hire_date
     , first_name ||'-'|| last_name 이름
  FROM employees;

-- 2. 입사년도가 02년도이거나 04년도인 사원의 사번, 입사일(----년 --월 --일)
-- 이름(first-last), 입사일 순으로 정렬, 별칭 => 사번, 입사일
SELECT employee_id 사번
     , '20' ||SUBSTR(hire_date,1,2)||'년 '
            ||SUBSTR(hire_date,4,2)||'월 '
            ||SUBSTR(hire_date,7,2)||'일' 입사일
     , first_name || '-' || last_name 이름
  FROM employees
 WHERE SUBSTR(hire_date,1,2) IN ('02', '04')
 ORDER BY hire_date;
 
--205	2002년 06월 07일	Shelley-Higgins
--206	2002년 06월 07일	William-Gietz
--204	2002년 06월 07일	Hermann-Baer
--203	2002년 06월 07일	Susan-Mavris
--109	2002년 08월 16일	Daniel-Faviet
--108	2002년 08월 17일	Nancy-Greenberg
--114	2002년 12월 07일	Den-Raphaely
--184	2004년 01월 27일	Nandita-Sarchand
--156	2004년 01월 30일	Janette-King
--192	2004년 02월 04일	Sarah-Bell
--201	2004년 02월 17일	Michael-Hartstein
--157	2004년 03월 04일	Patrick-Sully
--174	2004년 05월 11일	Ellen-Abel
--133	2004년 06월 14일	Jason-Mallin
--120	2004년 07월 18일	Matthew-Weiss
--158	2004년 08월 01일	Allan-McEwen
--145	2004년 10월 01일	John-Russell

/* 실습 6-10.
 * TRIM : 불필요한 공백 제거
 * LTRIM : 왼쪽 공백 제거
 * RTRIM : 오른쪽 공백 제거
 */
SELECT '    Oracle maina   '
    , TRIM('    Oracle mania    ') as trim
    , LTRIM('    Oracle mania    ') as l_trim
    , RTRIM('    Oracle mania    ') as r_trim
  FROM dual;