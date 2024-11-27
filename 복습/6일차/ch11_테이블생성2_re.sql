DROP TABLE member_tb1_re_copy;

SELECT * FROM member_tb1_re;

-- 방법 1) 테이블 생성시 데이터, 테이블 구조 복사 (CREATE + INSERT)
CREATE TABLE member_tb1_copy_re
    AS SELECT * FROM member_tb1_re;
    
CREATE TABLE member_tb1_copy2_re
    AS SELECT * FROM member_tb1_re
 WHERE 0 = 1;

INSERT INTO member_tb1_copy2_re
 SELECT * FROM member_tb1_re;

SELECT * FROM member_tb1_copy2_re;

ALTER TABLE member_tb1_copy_re
  ADD mem_joindate DATE default sysdate;

SELECT * FROM member_tb1_copy_re;

ALTER TABLE member_tb1_copy_re
RENAME column mem_joindate to joindate;

ALTER TABLE member_tb1_copy_re
 modify mem_email_re VARCHAR2(100);
 
desc member_tb1_Copy_re;

ALTER TABLE member_tb1_copy_re
 DROP COLUMN joindate;

RENAME member_tb1_copy_re TO member_tb1_rename_re;
SELECT * FROM member_tb1_copy_re; -- 없는 테이블
SELECT * FROM member_tb1_rename_re;

SELECT * FROM member_tb1_rename_re;
TRUNCATE TABLE member_tb1_rename_re;
SELECT * FROM member_tb1_rename_re;

