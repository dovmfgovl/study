--����1 ���缭���� ���� �䱸�ϴ� ���� ������ ���� SQL���� �ۼ��Ͻÿ�

--1.1 ������ȣ�� 1�� ������ �̸�
SELECT bookname
    FROM book
 WHERE bookid = 1;

--1.2 ������ 20000�� �̻��� ������ �̸�
SELECT bookname
    FROM book
 WHERE price >= 20000;

--1.3 �������� �� ���ž�
SELECT NAME, sum(saleprice)
 FROM customer, orders
WHERE customer.custid = orders.custid
  AND NAME = '������'
GROUP BY NAME;

--1.4 �������� ������ ������ ��
SELECT NAME, count(bookid)
 FROM customer, orders
WHERE customer.custid = orders.custid
  AND NAME = '������'
GROUP BY NAME;

--1.5 �������� ������ ������ ���ǻ� ��
SELECT count(publisher)
  FROM book
WHERE bookid IN (SELECT bookid 
                    FROM orders
                 WHERE custid IN (SELECT custid
                                    FROM customer
                                  WHERE NAME = '������'));

--1.6 �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
SELECT NAME, bookname, price, (price-saleprice)
  FROM customer c, orders o, book b
 WHERE C.CUSTID = O.CUSTID
   AND O.BOOKID = B.BOOKID
   AND NAME = '������';

--1.7 �������� �������� ���� ������ �̸�
SELECT bookname
  FROM book
 WHERE bookid NOT IN ( SELECT bookid FROM orders
                        WHERE custid IN (SELECT custid FROM customer WHERE NAME = '������'));

--����2 ���缭���� ��ڿ� �濵�ڰ� �䱸�ϴ� ���� ������ ���� SQL�� �ۼ��Ͻÿ�

--2.1 ���缭�� ������ �� ��
SELECT count(bookid)
    FROM book;

--2.2 ���缭���� ������ ����ϴ� ���ǻ��� �� ��
SELECT count(DISTINCT(publisher))
    FROM book;

--2.3 ��� ���� �̸�, �ּ�
SELECT NAME, address
    FROM customer;

--2.4 2020�� 7�� 4��~ 7�� 7�� ���̿� �ֹ����� ������ �ֹ���ȣ
SELECT orderid
  FROM orders
 WHERE orderdate BETWEEN '2020/07/04' AND '2020/07/07';

--2.5 2020�� 7�� 4�� ~ 7�� 7�� ���̿� �ֹ����� ������ ������ ������ �ֹ���ȣ
SELECT orderid
    FROM orders
 WHERE orderdate NOT BETWEEN '2020/07/04' AND '2020/07/07';

--2.6 ���� �达�� ���� �̸��� �ּ�
SELECT NAME, address
  FROM customer
 WHERE NAME LIKE '��%';

--2.7���� �达�̰� �̸��� '��'�� ������ ���� �̸��� �ּ�
SELECT NAME, address
  FROM customer
 WHERE NAME LIKE '��%��';

--2.8 �ֹ����� ���� ���� �̸�(�����������) 
SELECT NAME
  FROM customer
 WHERE custid NOT IN(SELECT custid FROM orders);

--2.9 �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��ձݾ�
SELECT sum(saleprice), avg(saleprice)
  FROM orders;

--2.10 ���� �̸��� ���� ���ž�
SELECT NAME, sum(saleprice)
  FROM customer NATURAL JOIN orders
 GROUP BY NAME;

--2.11 ���� �̸��� ���� ������ ���� ���
SELECT c.NAME, b.bookname
  FROM customer c, book b, orders o
 WHERE C.CUSTID = O.CUSTID
   AND B.BOOKID = O.BOOKID;

--2.12 ������ ����(book ���̺�) �� �ǸŰ���(Orders ���̺�) �� ���̰� ���� ���� �ֹ�
SELECT orderid
  FROM orders NATURAL JOIN book
 WHERE (price-saleprice) = ( SELECT max(price-saleprice) FROM orders NATURAL JOIN book);

    

--2.13 ������ �ĳ��� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�

--����3 ���缭������ ������ ��ȭ�� ������ ���� SQL ���� �ۼ��Ͻÿ�

--3.1 �������� ������ ������ ���ǻ�� ���� ���ǻ翡�� ������ ������ ���� �̸�

--3.2 �� �� �̻��� ���� �ٸ� ���ǻ翡�� ������ ������ ���� �̸�

--3.3 ��ü ���� 30% �̻��� ������ ����

--���� 4 ���� ���ǿ� ���� DDL���� DML ���� �ۼ��Ͻÿ�

--4.1 ���ο� ����('������ ����','���ѹ̵��','10000��')�� ���缭���� �԰�Ǿ���. ������ �� �� ��� �ʿ��� �����Ͱ� �� �ִ��� ã�ƺ��ÿ�

--4.2 '�Ｚ��' ���� ������ ������ �����Ͻÿ�

--4.3 '�̻�̵��' ���� ������ ������ �����Ͻÿ�. ������ �� �Ǹ� ������ �����غ��ÿ�

--4.4 ���ǻ� '���ѹ̵��'�� '�������ǻ�'�� �̸��� �ٲٽÿ�

--4.5 (���̺����) ���ǻ翡 ���� ������ �����ϴ� ���̺� Bookcompany(name, address,begin)�� �����ϰ����Ѵ�.

--name�� �⺻Ű�̸� VARCHAR(20), address�� VARCHAR(20), begin�� DATE Ÿ������ �����Ͽ� �����Ͻÿ�

--4.6 (���̺� ����) Bookcompany���̺� ���ͳ� �ּҸ� �����ϴ� webaddress�Ӽ��� VARCHAR(30)���� �߰��Ͻÿ�

--4.7 Bookcompany���̺� ������ Ʃ�� name=�Ѻ���ī����, address=����� ������, begin=1993-01-01, webaddress://hanbit.co.kr�� �����Ͻÿ�





--[���� 4-1] -78�� +78�� ������ ���Ͻÿ�.(ABS)

--[���� 4-2] 4.875�� �Ҽ� ù° �ڸ����� �ݿø��� ���� ���Ͻÿ�.(ROUND)

--[���� 4-3] ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���Ͻÿ�.(ROUND)

--[���� 4-4] ���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ����� ���̽ÿ�.(REPLACE)

--[���� 4-5] ���½����������� ������ ������ ����� ������ ���� ��, ����Ʈ ���� ���̽ÿ�.(LENGTH, LENGTHB)

--[���� 4-6] ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.(SUBSTR)

--[���� 4-7] ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.

--[���� 4-8] ���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. �� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.

--[���� 4-9] DBMS ������ ������ ���� ��¥�� �ð�, ������ Ȯ���Ͻÿ�.(NVL)

--[���� 4-10] �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̽ÿ�. ��, ��ȭ��ȣ�� ���� ���� ������ó���������� ǥ���Ͻÿ�.(ROWNUM)

--[���� 4-11] ����Ͽ��� ����ȣ, �̸�, ��ȭ��ȣ�� ���� �� �� ���̽ÿ�.

--[���� 4-12] ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.

--[���� 4-13] �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ, ����ȣ, �ݾ��� ���̽ÿ�.

--[���� 4-14] �����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.

--[���� 4-15] 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.(ALL)

--[���� 4-16] EXISTS �����ڸ� ����Ͽ� �����ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.(EXISTS)

--[���� 4-17] ���缭���� ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).

--[���� 4-19] ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ�(���̸��� ���� �Ǹž� ���).

--���⼭���ʹ� ��, �ε��� ���� --

--[���� 4-20] �ּҿ� �����ѹα����� �����ϴ� ����� ������ �並 ����� ��ȸ�Ͻÿ�. ���� �̸��� vw_Customer�� �����Ͻÿ�.

--[���� 4-21] Orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �並 ������ ��, ���迬�ơ� ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ����� ���̽ÿ�.

--[���� 4-22] [���� 4-20]���� ������ �� vw_Customer�� �ּҰ� �����ѹα����� ���� �����ش�. 

--[���� 4-23] �ռ� ������ �� vw_Customer�� �����Ͻÿ�.

--[���� 4-24] Book ���̺��� bookname ���� ������� �ε��� ix_Book�� �����Ͻÿ�.

--[���� 4-25] Book ���̺��� publisher, price ���� ������� �ε��� ix_Book2�� �����Ͻÿ�.

--[���� 4-26] �ε��� ix_Book�� ������Ͻÿ�.

--[���� 4-27] �ε��� ix_Book�� �����Ͻÿ�.