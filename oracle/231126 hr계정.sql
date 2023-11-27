--< Book ���̺� >
-- [���� 3-1] ��� ������ �̸��� ������ �˻��Ͻÿ�.
SELECT bookname, price
  FROM book;

-- [���� 3-2] ��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
SELECT * FROM book;

-- [���� 3-3] ���� ���̺� �ִ� ��� ���ǻ縦 �˻��Ͻÿ�.
SELECT publisher
    FROM book;

-- [���� 3-4] ������ 20,000�� �̸��� ������ �˻��Ͻÿ�.
SELECT bookname
    FROM book
WHERE price < 20000;

-- [���� 3-5] ������ 10,000�� �̻� 20,000 ������ ������ �˻��Ͻÿ�.
SELECT bookname
  FROM book
WHERE price BETWEEN 10000 AND 20000;

-- [���� 3-6] ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.
SELECT bookname
  FROM book
WHERE publisher IN('�½�����', '���ѹ̵��');

-- [���� 3-7] ���౸�� ���硯�� �Ⱓ�� ���ǻ縦 �˻��Ͻÿ�.
SELECT publisher
  FROM book
WHERE bookname = '�౸�� ����';

-- [���� 3-8] �����̸��� ���౸�� �� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
SELECT publisher
  FROM book
WHERE bookname LIKE '%�౸%';

-- [���� 3-9] �����̸��� ���� �� ��° ��ġ�� ��������� ���ڿ��� ���� ������ �˻��Ͻÿ�.
SELECT bookname
 FROM book
WHERE bookname LIKE '%_��%';

-- [���� 3-10] �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT bookname
  FROM book
WHERE bookname LIKE '%�౸%'
  AND price >= 20000;

-- [���� 3-11] ���ǻ簡 ���½������� Ȥ�� �����ѹ̵� �� ������ �˻��Ͻÿ�.
SELECT bookname
  FROM book
WHERE publisher IN ('�½�����', '���ѹ̵��');

-- [���� 3-12] ������ �̸������� �˻��Ͻÿ�.
SELECT bookname
 FROM book
ORDER BY bookname;

-- [���� 3-13] ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�.
SELECT bookname
  FROM book
ORDER BY price, bookname;

-- [���� 3-14] ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ ����Ͻÿ�.
SELECT bookname
  FROM book
ORDER BY price desc, publisher;

--< Orders ���̺� >
-- [���� 3-15] ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT sum(saleprice)
  FROM orders;

-- [���� 3-16] 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT max(o.custid), max(NAME), sum(saleprice)
  FROM orders o, customer c
WHERE o.custid = c.custid
  AND o.custid = 2;

-- [���� 3-17] ���� �ֹ��� ������ �� �Ǹž�, ��հ�, ������, �ְ��� ���Ͻÿ�.
SELECT sum(saleprice), avg(saleprice), min(saleprice), max(saleprice)
  FROM orders;

-- [���� 3-18] ���缭���� ���� �Ǹ� �Ǽ��� ���Ͻÿ�.
SELECT count(orderid)
  FROM orders;

-- [���� 3-19] ������ �ֹ��� ������ �� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT custid, count(custid),sum(saleprice)
  FROM orders
GROUP BY custid
ORDER BY custid;

-- [���� 3-20] ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. ��, �� �� �̻� ������ ���� ���Ͻÿ�.
SELECT custid, count(bookid)
 FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(custid) >= 2
ORDER BY custid;

--< ������ʹ� Customer, Orders, Book ���̺� �� �˾Ƽ� >
-- [���� 3-21] ���� ���� �ֹ��� ���� �����͸� ��� ���̽ÿ�.
SELECT * FROM orders;

--[���� 3-22] ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���̽ÿ�.
SELECT custid, orderid, bookid, saleprice, orderdate
  FROM orders
 ORDER BY custid;

--[���� 3-23] ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT NAME, bookname, saleprice
  FROM customer c, orders o, book b
WHERE b.bookid = o.bookid
  AND c.custid = O.CUSTID
ORDER BY NAME;

--[���� 3-24] ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT O.CUSTID, NAME, sum(saleprice)
  FROM customer c, orders o
WHERE C.CUSTID = O.CUSTID
GROUP BY o.custid, NAME
ORDER BY 1;

--[���� 3-25] ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
SELECT NAME, bookname
  FROM customer c, book b, orders o
WHERE B.BOOKID = O.BOOKID
  AND C.CUSTID = O.CUSTID
ORDER BY 1;
  
--[���� 3-26] ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
SELECT NAME, bookname
  FROM customer c, book b, orders o
WHERE b.bookid = o.bookid
  AND c.custid = o.custid
  AND price = 20000;

--[���� 3-27] ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.
SELECT NAME, saleprice
  FROM customer c LEFT JOIN orders o
    ON o.custid = c.custid;

--[���� 3-28] ���� ��� ������ �̸��� ���̽ÿ�.
SELECT bookname
  FROM book
WHERE price = (SELECT max(price) FROM book);
 
--[���� 3-29] ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
SELECT NAME
  FROM customer c, orders o
 WHERE C.CUSTID = O.CUSTID
GROUP BY NAME;

--��)
SELECT NAME
    FROM customer
 WHERE custid IN (SELECT custid FROM orders);

--[���� 3-30] �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT NAME
  FROM customer c, book b, orders o
WHERE C.CUSTID = O.CUSTID
  AND b.bookid = o.bookid
  AND publisher = '���ѹ̵��';
  
--��)
SELECT NAME
    FROM customer
 WHERE custid IN(SELECT custid
                    FROM orders
                  WHERE bookid IN(SELECT bookid
                                    FROM book
                                   WHERE publisher = '���ѹ̵��'));

--[���� 3-31] ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
----------Ʋ��.....--------------------
SELECT bookname
  FROM book
 WHERE price > (SELECT avg(price) FROM book);
 
--��)
SELECT b1.bookname
    FROM book b1
  WHERE B1.PRICE > (SELECT avg(b2.price)
                        FROM book b2
                      WHERE b2.publisher = b1.publisher);

--[���� 3-32] ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
--[Error] Execution (171: 19): ORA-01427: ���� �� ���� ���ǿ� 2�� �̻��� ���� ���ϵǾ����ϴ�.
--������ ���������� ��ȯ�ϴ� ����� �� �ϳ��� ���� ������ ��.
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
       
--��)
SELECT NAME
    FROM customer
MINUS
SELECT NAME
    FROM customer
 WHERE custid IN (SELECT custid FROM orders);

--[���� 3-33] �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT NAME, address
  FROM customer c
WHERE EXISTS (
        SELECT 1
          FROM orders o
        WHERE c.custid = o.custid);