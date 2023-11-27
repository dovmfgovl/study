--문제1 마당서점의 고객이 요구하는 다음 질문에 대해 SQL문을 작성하시오

--1.1 도서번호가 1인 도서의 이름
SELECT bookname
    FROM book
 WHERE bookid = 1;

--1.2 가격이 20000원 이상인 도서의 이름
SELECT bookname
    FROM book
 WHERE price >= 20000;

--1.3 박지성의 총 구매액
SELECT NAME, sum(saleprice)
 FROM customer, orders
WHERE customer.custid = orders.custid
  AND NAME = '박지성'
GROUP BY NAME;

--1.4 박지성이 구매한 도서의 수
SELECT NAME, count(bookid)
 FROM customer, orders
WHERE customer.custid = orders.custid
  AND NAME = '박지성'
GROUP BY NAME;

--1.5 박지성이 구매한 도서의 출판사 수
SELECT count(publisher)
  FROM book
WHERE bookid IN (SELECT bookid 
                    FROM orders
                 WHERE custid IN (SELECT custid
                                    FROM customer
                                  WHERE NAME = '박지성'));

--1.6 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT NAME, bookname, price, (price-saleprice)
  FROM customer c, orders o, book b
 WHERE C.CUSTID = O.CUSTID
   AND O.BOOKID = B.BOOKID
   AND NAME = '박지성';

--1.7 박지성이 구매하지 않은 도서의 이름
SELECT bookname
  FROM book
 WHERE bookid NOT IN ( SELECT bookid FROM orders
                        WHERE custid IN (SELECT custid FROM customer WHERE NAME = '박지성'));

--문제2 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL을 작성하시오

--2.1 마당서점 도서의 총 수
SELECT count(bookid)
    FROM book;

--2.2 마당서점에 도서를 출고하는 출판사의 총 수
SELECT count(DISTINCT(publisher))
    FROM book;

--2.3 모든 고객의 이름, 주소
SELECT NAME, address
    FROM customer;

--2.4 2020년 7월 4일~ 7월 7일 사이에 주문받은 도서의 주문번호
SELECT orderid
  FROM orders
 WHERE orderdate BETWEEN '2020/07/04' AND '2020/07/07';

--2.5 2020년 7월 4일 ~ 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
SELECT orderid
    FROM orders
 WHERE orderdate NOT BETWEEN '2020/07/04' AND '2020/07/07';

--2.6 성이 김씨인 고객의 이름과 주소
SELECT NAME, address
  FROM customer
 WHERE NAME LIKE '김%';

--2.7성이 김씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
SELECT NAME, address
  FROM customer
 WHERE NAME LIKE '김%아';

--2.8 주문하지 않은 고객의 이름(서브쿼리사용) 
SELECT NAME
  FROM customer
 WHERE custid NOT IN(SELECT custid FROM orders);

--2.9 주문 금액의 총액과 주문의 평균금액
SELECT sum(saleprice), avg(saleprice)
  FROM orders;

--2.10 고객의 이름과 고객별 구매액
SELECT NAME, sum(saleprice)
  FROM customer NATURAL JOIN orders
 GROUP BY NAME;

--2.11 고객의 이름과 고객이 구매한 도서 목록
SELECT c.NAME, b.bookname
  FROM customer c, book b, orders o
 WHERE C.CUSTID = O.CUSTID
   AND B.BOOKID = O.BOOKID;

--2.12 도서의 가격(book 테이블) 과 판매가격(Orders 테이블) 의 차이가 가장 많은 주문
SELECT orderid
  FROM orders NATURAL JOIN book
 WHERE (price-saleprice) = ( SELECT max(price-saleprice) FROM orders NATURAL JOIN book);

    

--2.13 도서의 파냄액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름

--문제3 마당서점에서 다음의 심화된 질문에 대해 SQL 문을 작성하시오

--3.1 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름

--3.2 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름

--3.3 전체 고객의 30% 이상이 구매한 도서

--문제 4 다음 질의에 대해 DDL문과 DML 문을 작성하시오

--4.1 새로운 도서('스포츠 세계','대한미디어','10000원')이 마당서점에 입고되었다. 삽입이 안 될 경우 필요한 데이터가 더 있는지 찾아보시오

--4.2 '삼성당' 에서 출판한 도서를 삭제하시오

--4.3 '이상미디어' 에서 출판한 도서를 삭제하시오. 삭제가 안 되면 원인을 생각해보시오

--4.4 출판사 '대한미디어'를 '대한출판사'로 이름을 바꾸시오

--4.5 (테이블생성) 출판사에 대한 정보를 저장하는 테이블 Bookcompany(name, address,begin)를 생성하고자한다.

--name은 기본키이며 VARCHAR(20), address는 VARCHAR(20), begin은 DATE 타입으로 선언하여 생성하시오

--4.6 (테이블 수정) Bookcompany테이블에 인터넷 주소를 저장하는 webaddress속성을 VARCHAR(30)으로 추가하시오

--4.7 Bookcompany테이블에 임의의 튜플 name=한빛아카데미, address=서울시 마포구, begin=1993-01-01, webaddress://hanbit.co.kr을 삽입하시오





--[질의 4-1] -78과 +78의 절댓값을 구하시오.(ABS)

--[질의 4-2] 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오.(ROUND)

--[질의 4-3] 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.(ROUND)

--[질의 4-4] 도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록을 보이시오.(REPLACE)

--[질의 4-5] ‘굿스포츠’에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.(LENGTH, LENGTHB)

--[질의 4-6] 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.(SUBSTR)

--[질의 4-7] 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.

--[질의 4-8] 마당서점이 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 단 주문일은 ‘yyyy-mm-dd 요일’ 형태로 표시한다.

--[질의 4-9] DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.(NVL)

--[질의 4-10] 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 ‘연락처없음’으로 표시하시오.(ROWNUM)

--[질의 4-11] 고객목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오.

--[질의 4-12] 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이시오.

--[질의 4-13] 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 보이시오.

--[질의 4-14] ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.

--[질의 4-15] 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오.(ALL)

--[질의 4-16] EXISTS 연산자를 사용하여 ‘대한민국’에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오.(EXISTS)

--[질의 4-17] 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액 출력).

--[질의 4-19] 고객번호가 2 이하인 고객의 판매액을 보이시오(고객이름과 고객별 판매액 출력).

--여기서부터는 뷰, 인덱스 생성 --

--[질의 4-20] 주소에 ‘대한민국’을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.

--[질의 4-21] Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, ‘김연아’ 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오.

--[질의 4-22] [질의 4-20]에서 생성한 뷰 vw_Customer는 주소가 ‘대한민국’인 고객을 보여준다. 

--[질의 4-23] 앞서 생성한 뷰 vw_Customer를 삭제하시오.

--[질의 4-24] Book 테이블의 bookname 열을 대상으로 인덱스 ix_Book을 생성하시오.

--[질의 4-25] Book 테이블의 publisher, price 열을 대상으로 인덱스 ix_Book2를 생성하시오.

--[질의 4-26] 인덱스 ix_Book을 재생성하시오.

--[질의 4-27] 인덱스 ix_Book을 삭제하시오.