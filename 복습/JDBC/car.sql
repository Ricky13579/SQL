DROP SEQUENCE CAR_SEQ;
CREATE SEQUENCE CAR_SEQ
    START WITH 1001
    INCREMENT BY 1
    MINVALUE 1001
    MAXVALUE 999999
    NOCYCLE
    NOCACHE;

DROP TABLE JDBC_CAR_TBL;
CREATE TABLE JDBC_CAR_TBL(
    carNo         NUMBER(4)        Primary Key, -- 차 고유번호
    kind          VARCHAR2(50), -- 차 종류(승용차, 오토바이 등등)
    manu_comp     VARCHAR2(100), -- 이 차의 제조사
    price         NUMBER  -- 이 차의 시세
);

commit;

