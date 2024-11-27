-- 02. SQL 개요
-- 예) 김연아 고객의 전화번호를 찾으시오.
SELECT name 고객명
     , phone 전화번호
  FROM customer
 WHERE name = '김연아';

-- 3.1.1 SELECT/FROM
-- 3-1 모든 도서의 이름과 가격을 검색하시오.
SELECT bookname 도서명
     , price 가격
  FROM book;

-- (3-1 변형) 모든 도서의 가격과 이름을 검색하시오.
SELECT price 가격
     , bookname 도서명
  FROM book;

-- 3-2 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT bookid 도서번호
     , bookname 도서이름
     , publisher 출판사
     , price 가격
  FROM book;

-- 3-3 도서 테이블에 있는 모든 출판사를 검색하시오.
SELECT publisher 출판사
  FROM book;

-- 3.1.2 WHERE 조건
-- 3-4 가격이 20,000원 미만인 도서를 검색하시오. -- 7건
SELECT bookid 도서번호
     , bookname 도서명
     , price 가격
  FROM book
 WHERE price < 20000;

-- 3-5 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오. -- 4건
SELECT bookid 도서번호
     , bookname 도서명
     , price 가격
  FROM book
 WHERE price >= 10000
   AND price <= 20000;

-- 3-6 출판사가 '굿스포츠'혹은 '대한미디어'인 도서를 검색하시오. -- 5건
SELECT bookid 도서번호
     , bookname 도서명
     , publisher 출판사
  FROM book
 WHERE publisher IN ('굿스포츠' , '대한미디어');

-- 3-7 '축구의 역사'를 출간한 출판사를 검색하시오. -- 굿스포츠
SELECT bookid 도서번호
     , bookname 도서명
     , publisher 출판사
  FROM book
 WHERE bookname = '축구의 역사';

-- 3-8 도서이름에 '축구'가 포함한 출판사를 검색하시오. -- 3건
SELECT bookid 도서번호
     , bookname 도서명
     , publisher 출판사
  FROM book
 WHERE bookname LIKE '%축구%';
 
-- 3-9 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오. -- 5건
SELECT bookid 도서번호
     , bookname 도서명
  FROM book
 WHERE bookname LIKE '_구%';

-- 3-10 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오. -- 3건
SELECT bookid 도서번호
     , bookname 도서명
     , publisher 출판사
     , price 가격
  FROM book
 WHERE price >= 2000
   AND bookname LIKE '%축구%';

-- 3-11 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 검색하시오. -- 5건
SELECT bookid 도서번호
     , bookname 도서명
     , publisher 출판사
  FROM book
 WHERE publisher = '굿스포츠'
    OR publisher = '대한미디어';

-- 3-12 도서를 이름순으로 검색하시오
SELECT bookid 도서번호
     , bookname 도서명
     , publisher 출판사
     , price 가격
  FROM book
 ORDER By bookname;
 
-- 3-13 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
SELECT bookid 도서번호
     , bookname 도서명
     , publisher 출판사
     , price 가격
  FROM book
 ORDER BY price, bookname;
 
-- 3-14 도서를 가격의 내림차순으로 검색하시오. 
-- 만약 가격이 같다면 출판사의 오름차순으로 검색한다.
SELECT bookid 도서번호
     , bookname 도서명
     , publisher 출판사
     , price 가격
  FROM book
 ORDER BY price desc, publisher;

-- 3-15 고객이 주문한 도서의 총 판매액을 구하시오. -- 118000
SELECT sum(saleprice) "총판매액"
  FROM orders;

-- 3-16 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오. -- 15000
SELECT sum(o.saleprice) "총판매액"
  FROM customer c, orders o
 WHERE c.custid = o.custid
   AND o.custid = 2;

-- 3-17 고객이 주문한 도서의 총판매액, 평균값, 최저가, 최고가를 구하시오 
SELECT sum(saleprice) "총 판매액"
     , avg(saleprice) "평균값"
     , min(saleprice) "최저가"
     , max(saleprice) "최고가"
  FROM orders;
-- 118000	11800	6000	21000

-- 3-18 마당서점의 도서 판매 건수를 구하시오. -- 10
SELECT count(*) "도서 판매 건수"
  FROM orders;

-- 3.2.2 GROUP BY
-- 3-19 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT custid 고객번호
     , count(*) "도서 총 수량"
     , sum(saleprice) "총 판매액"
  FROM orders
 GROUP BY custid;
-- 1	3	39000
-- 2	2	15000
-- 4	2	33000
-- 3	3	31000

-- 3-20 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
-- 단, 두 권 이상 구매한 고객만 구한다.
SELECT custid 고객번호
     , count(*) "주문도서 총 수량"
  FROM orders
 WHERE saleprice >= 8000
 GROUP BY custid
 HAVING count(custid) > 1; 
-- 1	2
-- 4	2
-- 3	2

-- 3-21 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
SELECT *
  FROM customer c, orders o
 WHERE c.custid = o.custid;
-- 1	박지성	영국 멘체스터	000-5000-0001	1	1	1	6000	14/07/01
-- 1	박지성	영국 멘체스터	000-5000-0001	2	1	3	21000	14/07/03
-- 2	김연아	대한민국 서울	000-6000-0001	3	2	5	8000	14/07/03
-- 3	장미란	대한민국 강원도	000-7000-0001	4	3	6	6000	14/07/04
-- 4	추신수	미국 클리브랜드	000-8000-0001	5	4	7	20000	14/07/05
-- 1	박지성	영국 멘체스터	000-5000-0001	6	1	2	12000	14/07/07
-- 4	추신수	미국 클리브랜드	000-8000-0001	7	4	8	13000	14/07/07
-- 3	장미란	대한민국 강원도	000-7000-0001	8	3	10	12000	14/07/08
-- 2	김연아	대한민국 서울	000-6000-0001	9	2	10	7000	14/07/09
-- 3	장미란	대한민국 강원도	000-7000-0001	10	3	8	13000	14/07/10

-- 3-22 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬하여 보이시오.
SELECT *
  FROM customer c, orders o
 WHERE c.custid = o.custid
 ORDER BY c.custid;
--1	박지성	영국 멘체스터	000-5000-0001	2	1	3	21000	14/07/03
--1	박지성	영국 멘체스터	000-5000-0001	6	1	2	12000	14/07/07
--1	박지성	영국 멘체스터	000-5000-0001	1	1	1	6000	14/07/01
--2	김연아	대한민국 서울	000-6000-0001	9	2	10	7000	14/07/09
--2	김연아	대한민국 서울	000-6000-0001	3	2	5	8000	14/07/03
--3	장미란	대한민국 강원도	000-7000-0001	4	3	6	6000	14/07/04
--3	장미란	대한민국 강원도	000-7000-0001	10	3	8	13000	14/07/10
--3	장미란	대한민국 강원도	000-7000-0001	8	3	10	12000	14/07/08
--4	추신수	미국 클리브랜드	000-8000-0001	7	4	8	13000	14/07/07
--4	추신수	미국 클리브랜드	000-8000-0001	5	4	7	20000	14/07/05

-- 3-23 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT c.name 고객명
     , o.saleprice 판매가격
  FROM customer c, orders o
 WHERE c.custid = o.custid;
-- 박지성	6000
-- 박지성	21000
-- 김연아	8000
-- 장미란	6000
-- 추신수	20000
-- 박지성	12000
-- 추신수	13000
-- 장미란	12000
-- 김연아	7000
-- 장미란	13000

-- 3-24 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT sum(saleprice) "총 판매액"
  FROM orders
 GROUP BY custid
 ORDER BY custid;
-- 39000
-- 15000
-- 31000
-- 33000

-- 3-25 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT c.name 고객명
     , b.bookname 도서명
  FROM book b, orders o, customer c
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid;
   
SELECT c.name 고객명
     , b.bookname 도서명
  FROM book b
  JOIN orders o
    ON b.bookid = o.bookid
  JOIN customer c
    ON c.custid = o.custid;
-- 박지성	축구의 역사
-- 박지성	축구아는 여자
-- 박지성	축구의 이해
-- 김연아	피겨교본
-- 장미란	역도 단계별기술
-- 추신수	야구의 추억
-- 장미란	야구를 부탁해
-- 추신수	야구를 부탁해
-- 김연아	Olympic Champions
-- 장미란	Olympic Champions

-- 3-26 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT c.name 고객명
     , b.bookname 도서명
  FROM book b, orders o, customer c
 WHERE c.custid = o.custid
   AND b.bookid = o.bookid
   AND b.price = 20000;
-- 추신수	야구의 추억

SELECT c.name 고객명
     , b.bookname 도서명
  FROM book b
  JOIN orders o
    ON b.bookid = o.bookid
  JOIN customer c
    ON c.custid = o.custid
 WHERE b.price = 20000;
-- 추신수	야구의 추억

-- 3-27 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
SELECT c.name 고객명
     , o.saleprice 판매가
  FROM orders o, customer c
 WHERE c.custid = o.custid(+); -- LEFT OUTER JOIN

SELECT c.name 고객명
     , o.saleprice 판매가
  FROM orders o
  RIGHT OUTER JOIN customer c 
    ON o.custid = c.custid; -- RIGHT OUTER JOIN

-- 3.3.2 부속질의
-- 3-28 가장 비싼 도서의 이름을 보이시오.
SELECT bookname 도서명
     , price 가격
  FROM book
 WHERE price = (SELECT max(price)
                  FROM book
 );
-- 골프바이블	 35000

-- 3-29 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT name 고객명
  FROM customer
 WHERE custid IN (SELECT custid
                   FROM orders 
 );
-- 박지성
-- 김연아
-- 장미란
-- 추신수

-- 3-30 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT name 고객명
  FROM orders o, customer c
 WHERE o.custid = c.custid
   AND bookid IN (SELECT bookid
                    FROM book
                   WHERE publisher = '대한미디어'
 );
-- 박지성

-- 3-31 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT *
  FROM book b
 WHERE b.price > (SELECT avg(k.price)
                    FROM book k
                   WHERE k.publisher = b.publisher
 );
-- 4	골프바이블	대한미디어	35000
-- 5	피겨교본	    굿스포츠	    8000
-- 7	야구의 추억	이상미디어	20000

-- 3-32 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT name 고객명
  FROM customer c
 WHERE c.custid NOT IN (SELECT o.custid
                          FROM orders o
 );
-- 박세리

-- 3-33 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT c.name 고객명
     , c.address 주소
  FROM customer c
 WHERE c.custid IN (SELECT o.custid
                      FROM orders o
 );
-- 박지성	영국 멘체스터
-- 김연아	대한민국 서울
-- 장미란	대한민국 강원도
-- 추신수	미국 클리브랜드

-- 4.1 CREATE 문
-- 3-34 다음과 같은 속성을 가진 NewBook 테이블을 생성하시오. 
-- 정수형은 NUMBER를, 문자형은 가변형 문자타입인 VARCHAR2를 사용한다.
--  bookid	NUMBER,
-- bookname  VARCHAR2(20),
-- publisher  VARCHAR2(20),
-- price      NUMBER);
CREATE TABLE NewBook(
    bookid      NUMBER,
    bookname    VARCHAR2(20),
    publisher   VARCHAR2(20),
    price       NUMBER
);
commit;

-- 3-35 다음과 같은 속성을 가진 NewCustomer 테이블을 생성하시오.
-- -custid(고객번호) NUMBER, 기본키
-- -name(이름)-VARCHAR2(40)
-- -address(주소)-VARCHAR2(40)
-- -phone(전화번호)-VARCHAR2(30)
CREATE TABLE NewCustomer(
    custid      NUMBER          primary key,
    name        VARCHAR2(40),
    address     VARCHAR2(40),
    phone       VARCHAR2(30)
);
commit;

-- 3-36 다음과 같은 속성을 가진 NewOrders 테이블을 생성하시오.
-- -orderid(주문번호)- NUMBER, 기본키
-- -custid(고객번호)- NUMBER, NOT NULL 제약조건, 외래키(NewCustomer.custid, 연쇄삭제)
-- -bookid(도서번호)- NUMBER, NOT NULL 제약조건
-- -saleprice(판매가격)-NUMBER
-- -orderdate(판매일자)-DATE
CREATE TABLE NewOrders(
    orderid     NUMBER  Primary Key,
    custid      NUMBER  not null,
    bookid      NUMBER  not null,
    saleprice   NUMBER,
    orderdate   DATE,
    foreign key(custid) references NewCustomer(custid) on delete cascade
);
commit;

--4.2 ALTER문
-- 3-37 NewBook 테이블에 VARCHAR2(13)의 자료형을 가진 isbn 속성을 추가하시오.
ALTER TABLE NewBook
  ADD isbn varchar2(13);
SELECT * from newbook;
commit;

-- 3-38 NewBook 테이블의 isbn 속성의 데이터 타입을 NUMBER형으로 변경하시오.
ALTER TABLE newbook
 modify isbn number;
-- Table NEWBOOK이(가) 변경되었습니다.

-- 3-39 NewBook 테이블의 isbn 속성을 삭제하시오.
ALTER TABLE newbook
 DROP COLUMN isbn;

-- 3-40 NewBook 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오.
ALTER TABLE newbook
modify bookid not null;

-- 3-41 NewBook 테이블의 bookid 속성을 기본키로 변경하시오.
ALTER TABLE newbook
modify bookid primary key;
commit;

-- 4.3 DROP 문
-- 3-42 NewBook 테이블을 삭제하시오.
DROP table newbook;
commit;

-- 3-43 NewCustomer 테이블을 삭제하시오. 
-- 만약 삭제가 거절된다면 원인을 파악하고 관련된 테이블을 같이 삭제하시오
-- (NewOrders 테이블이 NewCustomer를 참조하고 있음).
drop table neworders;
drop table newcustomer;
commit;