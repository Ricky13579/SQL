-- scott_04 계정에서 작업
-- 테이블 생성
DROP TABLE member_tb1_copy;

SELECT * FROM member_tb1;

-- 방법 1) 테이블 생성시 데이터, 테이블 구조 복사 (CREATE + INSERT)
CREATE TABLE member_tb1_copy
    AS SELECT * FROM member_tb1;
-- Table MEMBER_TB1_COPY이(가) 생성되었습니다.

-- 방법 2-1) 테이블 생성 시 데이터를 제외한, 테이블 구조 복사 (CREATE) => 단 제약조건은 복사 안됨
CREATE TABLE member_tb1_copy2
    AS SELECT * FROM member_tb1
 WHERE 0 = 1;

-- 방법 2-2) 테이블에 데이터 복사
INSERT INTO member_tb1_copy2
 SELECT * FROM member_tb1;
commit;

SELECT * FROM member_tb1_copy2;

/* 12-3. 테이블의 구조를 변경하는 ALTER TABLE문
 * 
 * 1) 컬럼추가 : ADD 컬럼명 데이터타입
 *    컬럼추가를 하면 테이블의 맨끝에 컬럼이 추가된다.
 *
 * [ 형식 ]
 * ALTER TABLE 테이블명
 * ADD 컬럼명 데이터타입
 *
 * 2) 열이름 변경 : RENAME COLUMN old_컬럼 TO new_컬럼
 */
-- 1) 컬럼추가 : ADD 컬럼명 데이터타입
ALTER TABLE member_tb1_copy
  ADD mem_joindate DATE default sysdate;

SELECT * FROM member_tb1_copy;

-- 2) 열이름 변경 : RENAME COLUMN old_컬럼 TO new_컬럼
ALTER TABLE member_tb1_copy
RENAME column mem_joindate to mem_join_date;

/*
 * 3) 컬럼의 자료형 변경 : MODIFY 컬럼명 데이터타입
 * => 기존 데이터는 그대로 유지하면서 데이터타입, 크기, 기본값을 변경한다.
 *
 * [ 형식 ]
 * ALTER TABLE 테이블명
 * MODIFY 컬럼명 데이터타입
 */
-- 3) 컬럼 자료형 변경 : MODIFY
ALTER TABLE member_tb1_copy
 modify mem_email VARCHAR2(100);
desc member_tb1_Copy;

/*
 * 4) 컬럼제거 : DROP COLUMN 컬럼명
 * => 기존 데이터는 그대로 유지
 *
 * [형식]
 * ALTER TABLE 테이블명
 * DROP COLUMN 컬럼명
 */
-- 4) 컬럼 삭제 : DROP COLUMN
ALTER TABLE member_tb1_copy
 DROP COLUMN mem_join_date;

/*
 * 5) 테이블 이름 변경 RENAME TO
 *
 * [형식]
 * ALTER TABLE [old 테이블명]
 * RENAME TO [new 테이블명]
 
 * 또는 RENAME[old 테이블명] TO [new 테이블명]
 */
RENAME member_tb1_copy TO member_tb1_rename;
SELECT * FROM member_tb1_copy; -- 없는 테이블
SELECT * FROM member_tb1_rename;

/*
 * 12-4. 테이블의 데이터를 전체 삭제하는 TRUNCATE문
 *   => 데이터 정의어이므로 자동커밋되기 때문에 롤백이 안됨. (WHERE절이 없는 DELETE(롤백이 된다)와 동일)
 *
 * [형식]
 * TRUNCATE TABLE 테이블명
 */
SELECT * FROM member_tb1_rename;
TRUNCATE TABLE member_tb1_rename;
SELECT * FROM member_tb1_rename;

/*
 * 12-5. 테이블을 삭제하는 DROP문
 *   => 테이블 자체 삭제
 *
 * [형식]
 * DROP TABLE 테이블명
 */