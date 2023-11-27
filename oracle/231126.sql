--< Book 테이블 >
-- [질의 3-1] 모든 도서의 이름과 가격을 검색하시오.
SELECT bookname, price
  FROM book;

-- [질의 3-2] 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
SELECT * FROM book;

-- [질의 3-3] 도서 테이블에 있는 모든 출판사를 검색하시오.
SELECT publisher
    FROM book;

-- [질의 3-4] 가격이 20,000원 미만인 도서를 검색하시오.
SELECT bookname
    FROM book
WHERE price < 20000;

-- [질의 3-5] 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
SELECT bookname
  FROM book
WHERE price BETWEEN 10000 AND 20000;

-- [질의 3-6] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT bookname
  FROM book
WHERE publisher IN('굿스포츠', '대한미디어');

-- [질의 3-7] ‘축구의 역사’를 출간한 출판사를 검색하시오.
SELECT publisher
  FROM book
WHERE bookname = '축구의 역사';

-- [질의 3-8] 도서이름에 ‘축구’ 가 포함된 출판사를 검색하시오.
SELECT publisher
  FROM book
WHERE bookname LIKE '%축구%';

-- [질의 3-9] 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT bookname
 FROM book
WHERE bookname LIKE '%_구%';

-- [질의 3-10] 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT bookname
  FROM book
WHERE bookname LIKE '%축구%'
  AND price >= 20000;

-- [질의 3-11] 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’ 인 도서를 검색하시오.
SELECT bookname
  FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

-- [질의 3-12] 도서를 이름순으로 검색하시오.
SELECT bookname
 FROM book
ORDER BY bookname;

-- [질의 3-13] 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT bookname
  FROM book
ORDER BY price, bookname;

-- [질의 3-14] 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 출력하시오.
SELECT bookname
  FROM book
ORDER BY price desc, publisher;

--< Orders 테이블 >
-- [질의 3-15] 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT sum(saleprice)
  FROM orders;

-- [질의 3-16] 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT max(o.custid), max(NAME), sum(saleprice)
  FROM orders o, customer c
WHERE o.custid = c.custid
  AND o.custid = 2;

-- [질의 3-17] 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT sum(saleprice), avg(saleprice), min(saleprice), max(saleprice)
  FROM orders;

-- [질의 3-18] 마당서점의 도서 판매 건수를 구하시오.
SELECT count(orderid)
  FROM orders;

-- [질의 3-19] 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT custid, count(custid),sum(saleprice)
  FROM orders
GROUP BY custid
ORDER BY custid;

-- [질의 3-20] 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 구하시오.
SELECT custid, count(bookid)
 FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(custid) >= 2
ORDER BY custid;

--< 여기부터는 Customer, Orders, Book 테이블 중 알아서 >
-- [질의 3-21] 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
SELECT * FROM orders;

--[질의 3-22] 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오.
SELECT custid, orderid, bookid, saleprice, orderdate
  FROM orders
 ORDER BY custid;

--[질의 3-23] 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT NAME, bookname, saleprice
  FROM customer c, orders o, book b
WHERE b.bookid = o.bookid
  AND c.custid = O.CUSTID
ORDER BY NAME;

--[질의 3-24] 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT O.CUSTID, NAME, sum(saleprice)
  FROM customer c, orders o
WHERE C.CUSTID = O.CUSTID
GROUP BY o.custid, NAME
ORDER BY 1;

--[질의 3-25] 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT NAME, bookname
  FROM customer c, book b, orders o
WHERE B.BOOKID = O.BOOKID
  AND C.CUSTID = O.CUSTID
ORDER BY 1;
  
--[질의 3-26] 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT NAME, bookname
  FROM customer c, book b, orders o
WHERE b.bookid = o.bookid
  AND c.custid = o.custid
  AND price = 20000;

--[질의 3-27] 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
SELECT NAME, saleprice
  FROM customer c LEFT JOIN orders o
    ON o.custid = c.custid;

--[질의 3-28] 가장 비싼 도서의 이름을 보이시오.
SELECT bookname
  FROM book
WHERE price = (SELECT max(price) FROM book);
 
--[질의 3-29] 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT NAME
  FROM customer c, orders o
 WHERE C.CUSTID = O.CUSTID
GROUP BY NAME;

--답)
SELECT NAME
    FROM customer
 WHERE custid IN (SELECT custid FROM orders);

--[질의 3-30] ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT NAME
  FROM customer c, book b, orders o
WHERE C.CUSTID = O.CUSTID
  AND b.bookid = o.bookid
  AND publisher = '대한미디어';
  
--답)
SELECT NAME
    FROM customer
 WHERE custid IN(SELECT custid
                    FROM orders
                  WHERE bookid IN(SELECT bookid
                                    FROM book
                                   WHERE publisher = '대한미디어'));

--[질의 3-31] 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
----------틀림.....--------------------
SELECT bookname
  FROM book
 WHERE price > (SELECT avg(price) FROM book);
 
--답)
SELECT b1.bookname
    FROM book b1
  WHERE B1.PRICE > (SELECT avg(b2.price)
                        FROM book b2
                      WHERE b2.publisher = b1.publisher);

--[질의 3-32] 도서를 주문하지 않은 고객의 이름을 보이시오.
--[Error] Execution (171: 19): ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
--단일행 서브쿼리는 반환하는 결과가 단 하나의 값만 가져야 함.
SELECT NAME
  FROM customer c, orders o
 WHERE C.CUSTID != O.CUSTID
  AND orderid <> (SELECT orderid FROM orders);
  
SELECT NAME
  FROM customer c
WHERE NOT EXISTS (
      SELECT 1
        FROM orders o
       WHERE C.CUSTID = O.CUSTID);
       
--답)
SELECT NAME
    FROM customer
MINUS
SELECT NAME
    FROM customer
 WHERE custid IN (SELECT custid FROM orders);

--[질의 3-33] 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT NAME, address
  FROM customer c
WHERE EXISTS (
        SELECT 1
          FROM orders o
        WHERE c.custid = o.custid);