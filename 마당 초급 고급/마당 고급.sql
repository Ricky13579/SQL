-- 5.1 INSERT 문
-- 3-44 Book 테이블에 새로운 도서 '스포츠 의학'을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 90,000원이다.
INSERT INTO book
 VALUES(11, '스포츠 의학', '한솔의학서적', 90000);

-- 3-45 Book 테이블에 새로운 도서 '스포츠 의학'을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 미정이다.
INSERT INTO book(bookid, bookname, publisher)
 VALUES(12, '스포츠 의학', '한솔의학서적');

-- 3-46 수입도서 목록(Imported_book)을 Book 테이블에 모두 삽입하시오.
--(Imported_book 테이블은 스크립트 Book 테이블과 같이 이미 만들어져 있음)
INSERT INTO book
 SELECT * FROM imported_book;

-- 3-47 Customer 테이블에 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오.
UPDATE customer
   SET address = '대한민국 부산'
 WHERE custid = 5;

-- 3-48 Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
UPDATE customer
   SET address = (SELECT address
                    FROM customer
                   WHERE name = '김연아')
 WHERE name = '박세리';

-- 3-49 Customer 테이블에서 고객번호가 5인 고객을 삭제하시오.
DELETE FROM customer
 WHERE custid = 5;

-- 3-50 모든 고객을 삭제하시오.
DELETE FROM customer;

-- 1.1.1 수학함수
-- 4-1 -78과 +78의 절댓값을 구하시오.
SELECT abs(-78) "절대값"
     , abs(78) 절대값
  FROM dual;
-- 78	78


-- 4-2 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오. -- 4.9
SELECT round(4.875, 1) "반올림한 값"
  FROM dual;

-- 4-3 고객별 평균 주문 금액을 백 원 단위로 반올림한 값을 구하시오.
SELECT custid 고객번호
     , round(avg(saleprice), -2) "반올림한 금액"
  FROM orders
 GROUP BY custid;
-- 1	13000
-- 2	7500
-- 4	16500
-- 3	10300

-- 4-4 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오.
SELECT bookid 도서번호
     , replace(bookname, '야구', '농구') 책이름
     , publisher 출판사
     , price 가격
  FROM book;
  

-- 4-5 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수를 확인하시오.
-- (한글은 2바이트 혹은 UNICODE 경우는 3바이트를 차지함)
SELECT bookname 책제목
     , length(bookname) 글자수
     , lengthb(bookname) 바이트수
  FROM book;

-- 4-6 마당서점의 고객 중에서 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
SELECT substr(name, 1, 1) 성
     , count(*) 인원수
  FROM customer
 GROUP BY substr(name, 1, 1);
-- 김	1
-- 장	1
-- 추	1
-- 박	1

-- 1.1.3 날짜함수
-- 4-7 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
SELECT orderid 주문번호
     , orderdate 주문일
     , orderdate + 10 "확정일자"
  FROM orders;
-- 1	14/07/01	14/07/11
-- 2	14/07/03	14/07/13
-- 3	14/07/03	14/07/13
-- 4	14/07/04	14/07/14
-- 5	14/07/05	14/07/15
-- 6	14/07/07	14/07/17
-- 7	14/07/07	14/07/17
-- 8	14/07/08	14/07/18
-- 9	14/07/09	14/07/19
-- 10	14/07/10	14/07/20

-- 4-8 마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 
--     단 주문일은 'yyyy-mm-dd 요일' 형태로 표시한다.
SELECT orderid 주문번호
     , to_char(orderdate, 'YYYY-MM-DD DAY') 주문일
     , custid 고객번호
     , bookid 도서번호
  FROM orders
 WHERE orderdate = '2014/07/07';
-- 6	2014-07-07 월요일	1	2
-- 7	2014-07-07 월요일	4	8

-- 4-9 DBMS 서버에 설정된 현재 시간과 오늘 날짜를 확인하시오.
SELECT to_char(sysdate, 'hh:mi:ss YYYY-MM-DD') "현재 시간과 오늘 날짜"
  FROM dual;

-- 4-10 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시한다.
SELECT name 이름
     , nvl(phone, '연락처없음') 전화번호
  FROM customer;
-- 박지성	000-5000-0001
-- 김연아	000-6000-0001
-- 장미란	000-7000-0001
-- 추신수	000-8000-0001

-- 4-11 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.
SELECT ROWNUM 순번 -- SELECT 해온 데이터에 일련번호를 붙이는 컬럼(제한적으로 가져오고 싶을 때 주로 사용)
     , custid 고객번호
     , name 고객명
     , phone 전화번호
  FROM customer
 WHERE rownum <= 2;
-- 순번   고객번호    고객명     전화번호
--  1	    1	    박지성	000-5000-0001
--  2	    2	    김연아	000-6000-0001

-- 4-12 마당서점의 고객별 판매액을 보이시오(결과는 고객이름과 고객별 판매액을 출력).
SELECT (SELECT c.name
          FROM customer c
         WHERE o.custid = c.custid) 고객이름
     , sum(saleprice) 판매액
  FROM orders o
 GROUP BY custid;
-- 박지성	39000
-- 김연아	15000
-- 추신수	33000
-- 장미란	31000

-- 4-13 Order 테이블에 각 주문에 맞는 도서이름을 입력하시오.
-- ORDERS 테이블에 bookname이란 컬럼을 추가
ALTER TABLE orders
  ADD bookname VARCHAR2(40);

-- 요구한 문제에 맞게 데이터를 입력할 질의문  
UPDATE orders o
   SET bookname = (SELECT bookname
                     FROM book b
                    WHERE b.bookid = o.bookid);
-- 10개 행 이(가) 업데이트되었습니다.
 
-- 4-14 고객번호가 2이하인 고객의 판매액을 보이시오 (결과는 고객이름과 고객별 판매액 출력)
-- 카페에 있는 방법
SELECT two.name 고객이름
     , sum(o.saleprice) 판매액
  FROM (SELECT custid, name
          FROM customer
         WHERE custid <=2) two,
         orders o
 WHERE two.custid = o.custid
 GROUP BY two.name;
-- 1	박지성	39000
-- 2	김연아	15000  

-- 직접 한 방법
SELECT (SELECT c.name
          FROM customer c
         WHERE o.custid = c.custid) 고객이름
     , sum(saleprice) 판매액
  FROM orders o
 GROUP BY custid
 HAVING custid <= 2;
-- 1	박지성	39000
-- 2	김연아	15000

-- 2.3 중첩질의 - WHERE 부속질의
-- 4-15 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.
SELECT orderid 주문번호
     , saleprice 금액
  FROM orders
 WHERE saleprice <= (SELECT avg(saleprice)
                       FROM orders);
-- 1	6000
-- 3	8000
-- 4	6000
-- 9	7000

-- 4-16 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.
SELECT orderid 주문번호
     , custid 고객번호
     , saleprice 금액
  FROM orders
 WHERE saleprice > (SELECT avg(saleprice)
                       FROM orders);
-- 2	1	21000
-- 5	4	20000
-- 6	1	12000
-- 7	4	13000
-- 8	3	12000
-- 10	3	13000

-- 4-17 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
SELECT sum(o.saleprice) "총판매액"
  FROM orders o
 WHERE custid IN (SELECT custid
                   FROM customer c
                  WHERE address LIKE '%대한민국%');
 -- 46000

-- 4-18 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.
SELECT orderid 주문번호
     , saleprice 금액
  FROM orders
 WHERE saleprice > (SELECT max(saleprice)
                       FROM orders
                      WHERE orderid = 3);
-- 2	21000
-- 5	20000
-- 6	12000
-- 7	13000
-- 8	12000
-- 10	13000

-- 4-19 EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오. -- 46000
SELECT sum(saleprice) "총 판매액"
  FROM orders o
 WHERE EXISTS(SELECT *
                FROM customer c
               WHERE address LIKE '%대한민국%'
                 AND c.custid = o.custid);

-- 4-20 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오.
--     단, 뷰의 이름은 vw_Customer로 한다.
CREATE OR REPLACE view vw_Customer
AS
SELECT *
  FROM customer
 WHERE address LIKE '%대한민국%';

SELECT * FROM vw_Customer;
-- 2	김연아	대한민국 서울	    000-6000-0001
-- 3	장미란	대한민국 강원도	000-7000-0001

-- 4-21 Orders 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, 
-- '김연아' 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오
-- 뷰 생성
CREATE OR REPLACE view v_orders
AS
SELECT o.orderid
     , o.custid
     , o.bookid
     , c.name
     , b.bookname
     , o.saleprice
  FROM orders o, customer c, book b
 WHERE o.bookid = b.bookid
   AND o.custid = c.custid;
   
SELECt * FROM v_orders;

-- 김연아 고객
SELECT orderid 주문번호
     , bookname 책제목
     , saleprice 주문액
  FROM v_orders
 WHERE name = '김연아';
-- 9	Olympic Champions	7000
-- 3	피겨교본	            8000

-- 4-22 [질의 4-20]에서 생성한 뷰 vw_Customer는 주소가 대한민국인 고객을 보여준다.
-- 이 뷰를 영국을 주소로 가진 고객으로 변경하시오. phone속성은 필요 없으므로 포함시키지 마시오.
CREATE OR REPLACE view vw_Customer
AS
SELECT *
  FROM customer
 WHERE address LIKE '%영국%';

SELECT * FROM vw_Customer;
-- 1	박지성	영국 멘체스터	000-5000-0001

-- 4-23 앞서 생성한 뷰 vw_Customer를 삭제하시오.
DROP view vw_customer;
-- View VW_CUSTOMER이(가) 삭제되었습니다.

-- 4-24 Book 테이블의 bookname 열을 대상으로 비 클러스터 인덱스 ix_Book을 생성하라.
CREATE INDEX ix_book ON BOOK(bookname);
-- Index IX_BOOK이(가) 생성되었습니다.
SELECT index_name, table_name
  FROM user_indexes;

-- SYS_C007083	ORDERS
-- SYS_C007081	CUSTOMER
-- SYS_C007082	BOOK
-- IX_BOOK	BOOK  

-- 4-25 Book 테이블의 publisher, price 열을 대상으로 인덱스 ix_Book2를 생성하시오.
CREATE INDEX ix_book2 ON book(publisher, price);
-- SYS_C007083	ORDERS
-- SYS_C007081	CUSTOMER
-- SYS_C007082	BOOK
-- IX_BOOK	BOOK
-- IX_BOOK2	BOOK

-- 4-26 인덱스 ix_Book을 재생성하시오.
ALTER INDEX ix_book rebuild;
-- Index IX_BOOK이(가) 변경되었습니다.

SELECT index_name, table_name
  FROM user_indexes;
-- SYS_C007083	ORDERS
-- SYS_C007081	CUSTOMER
-- SYS_C007082	BOOK
-- IX_BOOK	BOOK
-- IX_BOOK2	BOOK

-- 4-27 인덱스 ix_Book을 삭제하시오.
DROP INDEX ix_book;
-- Index IX_BOOK이(가) 삭제되었습니다.

SELECT index_name, table_name
  FROM user_indexes;
-- SYS_C007083	ORDERS
-- SYS_C007081	CUSTOMER
-- SYS_C007082	BOOK
-- IX_BOOK2	    BOOK