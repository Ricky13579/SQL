-- 계정생성(System_04 계정에서) 1. ~ 2.
-- 오라클 설치하는 순간 계정(SYSTEM)/비밀번호 (oracle)로 설치
-- ㄴ>관리자로 사용하기 위해 접속한다.
-- 모든 계정은 관리자인 SYSTEM_04 계정에서 계정 생성

-- 1. 사용자 계정생성 : scott_04 계정생성 .. 1,2,3번
-- create user <계정이름> identified by <계정암호> default tablespace users;
create user scott_04 identified by tiger default tablespace users;

-- 2. 사용자 권한 부여
-- grant [시스템 권한] to [계정];
grant connect, resource, create view, create session to scott_04;

-- 3. 락 해제
-- alter user <계정이름> account unlock;
alter user scott_04 account unlock;

-- 4. +로 접속해서 위 정보를 연결한다.

//////////////////////////////////////////////////////

-- hr 계정사용(오라클에서 제공하는 인사관리 데이터) .. 2, 3, 5번
-- 2. 사용자 권한 부여
-- grant [시스템 권한] to [계정];
grant connect, resource, create view, create session to hr;

-- 3. 락 해제
-- alter user <계정이름> account unlock;
alter user hr account unlock;

-- 5. 패스워드 변경
--alter user <계정이름> identified by <패스워드>;
alter user hr identified by tiger; 

-- 6. +로 접속해서 위 정보를 연결한다.
/////////////////////////////////////////////////////////

--  권한취소
-- revoke [시스템 권한] from [계정];
-- revoke create view from jdbc;

-- 4. 계정 잘못만든 경우 계정, 객체 삭제하기 
-- drop user <계정이름> cascade;
-- drop user hr cascade; 

/////////////////////////////////////////////////////////
-- [관리자 유효기간 만료시 커맨드 접속]

-- C:\Users\ict01-00>sqlplus /"as sysdba"
--
--SQL> select * from dba_profiles where profile = 'DEFAULT'; // 유효기간 확인
--SQL> alter profile default limit password_life_time unlimited; // 유효기간 unlimited로 변경
--
--SQL> select * from dba_profiles where resource_name = 'PASSWORD_LIFE_TIME'; // 다시 확인
--
--PROFILE
--------------------------------------------------------------
--RESOURCE_NAME
------------------------------------------------------------------
--RESOURCE_TYPE
------------------
--LIMIT
----------------------------------------------------------------------------------
--DEFAULT
--PASSWORD_LIFE_TIME
--PASSWORD
--UNLIMITED
--
--
--SQL>alter user system account unlock;
--SQL> alter user system identified by oracle;

