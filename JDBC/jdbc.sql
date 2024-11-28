-- 회원정보
-- scott_04에서 생성
DROP TABLE jdbc_member_tb1;
CREATE TABLE jdbc_member_tb1(
    id          VARCHAR2(20) primary key,
    password    VARCHAR2(20) not null,
    gender      VARCHAR2(10),
    email       VARCHAR2(50) unique not null,
    address     VARCHAR2(100)
);

INSERT INTO jdbc_member_tb1(id, password, gender, email, address)
 VALUES('test', 't1234', '남성', 'test@gmail.com', '맨하튼');
 
SELECT * FROM jdbc_member_tb1; 
commit;
 
UPDATE jdbc_member_tb1
   SET address = '파리 에펠탑'
 WHERE id = 'test';
 
DELETE jdbc_member_tb1;
commit;

DROP TABLE jdbc_book_tbl;
CREATE TABLE jdbc_book_tbl(
    bookNo      NUMBER          primary key,
    bookTitle   VARCHAR2(100),
    bookAuthor  VARCHAR2(100),
    price       NUMBER
    constraint jdbc_book_tbl_price_ck   CHECK(price >= 0)
);

DELETE jdbc_book_tbl;
commit;