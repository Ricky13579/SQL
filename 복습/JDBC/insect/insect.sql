CREATE SEQUENCE INSECT_SEQ
    START WITH 1001
    INCREMENT BY 1
    MINVALUE 1001
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;

-- 곤충 테이블
DROP TABLE JDBC_INSECT_TBL;
CREATE TABLE JDBC_INSECT_TBL(
    insectNo    NUMBER(4)       PRIMARY KEY,
    insectName  VARCHAR2(100)   not null,
    habitatNo   Number(4)       References JDBC_HABITAT_TBL(habitatNo) 
        ON delete cascade,
    predatorNo   Number(4)      References JDBC_PREDATOR_TBL(predatorNo) 
        ON delete cascade,
    taste       VARCHAR2(50)    not null
);

-- 서식지 테이블
DROP TABLE JDBC_HABITAT_TBL;
CREATE TABLE JDBC_HABITAT_TBL(
    habitatNo    NUMBER(4)       PRIMARY KEY,
    habitat  VARCHAR2(200)   not null
);

DROP TABLE JDBC_PREDATOR_TBL;
CREATE TABLE JDBC_PREDATOR_TBL(
    predatorNo    NUMBER(4)       PRIMARY KEY,
    name  VARCHAR2(200)   not null
);