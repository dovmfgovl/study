/*<TOAD_FILE_CHUNK>*/

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


--[���� 5-3] Book ���̺� ����� ������ ��հ����� ��ȯ�ϴ� ���ν����� �ۼ��Ͻÿ�.

CREATE OR REPLACE PROCEDURE proc_avg
IS
    avg_price number(10);
BEGIN
    SELECT avg(price) INTO avg_price
        FROM book;
        dbms_output.put_line('������ ��հ����� '|| avg_price ||'�� �Դϴ�.');
END;
/

/*<TOAD_FILE_CHUNK>*/
--[���� 5-4] Orders ���̺��� �Ǹ� ������ ���� ������ ����ϴ� ���ν����� �ۼ��Ͻÿ�.

CREATE OR REPLACE PROCEDURE proc_profit
IS
    profit_price number(10);
BEGIN
    SELECT sum(saleprice) INTO profit_price
        FROM orders;
        dbms_output.put_line('�Ǹ� ���� ������ '|| profit_price);
END;

--��������


--1. ���� ���α׷��� ���ν����� �ۼ��ϰ� �����Ͻÿ�. DB�� ���缭���� �̿�

--1.1 ���� ���� ����ϴ� InsertCustomer()���ν����� �ۼ��Ͻÿ�

CREATE OR REPLACE PROCEDURE proc_insertCustomer(p_custid IN number, p_name IN varchar2)
IS
BEGIN 
    INSERT INTO customer(custid, NAME) VALUES(p_custid, p_name);
    COMMIT;
END;

--1.2 ���ο� ������ �����ϴ�  BookInsertOrUpdate() ���ν����� �ۼ�, ������ ������ �ִٸ� ������ ���� ���� ������Ʈ

CREATE OR REPLACE PROCEDURE proc_bookInsertOrUpdate(p_bookid IN number, p_bookname IN varchar2, p_price IN number)
IS
BEGIN
    --���� ���ڵ尡 �����ϴ��� Ȯ��
    DECLARE
        p_count number;
    BEGIN 
        SELECT count(*) INTO p_count FROM book WHERE bookid = p_bookid;
        
        --�����ϸ� ������Ʈ
        IF p_count > 0 THEN
             UPDATE book
                set price = p_price 
              WHERE bookid = p_bookid AND p_price > price;
         ELSE
            -- �������� ������ ����
             INSERT INTO book(bookid, bookname, price) VALUES(p_bookid, p_bookname, p_price);
        END IF;
      END;
    COMMIT;
END;

--2. ���� ���α׷��� ���ν����� �ۼ��ϰ� �����Ͻÿ�. DB�� ���缭���� �̿�

--2.1 ���ǻ簡 '�̻�̵��' �� ������ �̸��� ������ �����ִ� ���ν����� �ۼ�
-- ���� ������ �ִ� ��� , �ϳ��� �ุ ����ϴ� ��������

CREATE OR REPLACE PROCEDURE proc_publisher(p_publisher IN varchar2, msg OUT varchar2)
IS
     bookname varchar2(100);
     price number(9);
BEGIN
    SELECT bookname, price INTO bookname, price
        FROM book
     WHERE publisher = p_publisher AND ROWNUM = 1; -- ���� �ϳ��� �ุ ����
     --���õ� ���� �ִ��� Ȯ�� . ������ �޽��� ��µǵ��� ����
     IF SQL%FOUND THEN
        COMMIT;        
        msg := p_publisher ||'���ǻ��� ������ '|| bookname ||'�̰�, ������ '|| price || '�� �̴�.';
     ELSE
        msg := p_publisher || ' ���ǻ��� ������ �������� �ʽ��ϴ�.';
     END IF;
END;

-- ���� ������ �ִ� ���, ��� ���� ����ϴ� �������� -> bookname�� price�� ��� �� ��.....

CREATE OR REPLACE PROCEDURE proc_publisher2(p_publisher IN varchar2, msg OUT varchar2)
IS
     bookname varchar2(100);
     price number(9);
BEGIN
    FOR book_publisher IN (SELECT bookname, price INTO bookname, price
        FROM book
     WHERE publisher = p_publisher)
     LOOP
        COMMIT;
         msg := p_publisher ||'���ǻ��� ������ '|| bookname ||'�̰�, ������ '|| price || '�� �̴�.';
     END LOOP;
     --���õ� ���� �ִ��� Ȯ�� . ������ �޽��� ��µǵ��� ����
     IF SQL%FOUND THEN 
        msg := p_publisher || ' ���ǻ��� ������ �������� �ʽ��ϴ�.';
     END IF;
END;

-- ���� ������ �ִ� ���, ��� ���� ����ϴ� refcursor ��������

CREATE OR REPLACE PROCEDURE proc_publisher3(rc_publisher OUT sys_refcursor)
IS
BEGIN
    OPEN rc_publisher
    FOR SELECT bookname, price FROM book WHERE publisher = '�̻�̵��';
END;

���) 
SQL> variable rc_publisher refcursor;
SQL> exec proc_publisher3(:rc_publisher);

PL/SQL ó���� ���������� �Ϸ�Ǿ����ϴ�.

SQL> print rc_publisher;

BOOKNAME                                      PRICE
---------------------------------------- ----------
�߱��� �߾�                           20000
�߱��� ��Ź��                         13000

--2.2 ���ǻ纰�� ���ǻ� �̸��� ������ �Ǹ� �Ѿ��� ���̽ÿ�(Orders ���̺� �̿�)
--cursor ���: SELECT���� ���� ���� ��ȯ�� �� ���� ��, Ŀ���� ����Ͽ� �� ���� �ݺ������� ó���Ѵ�.

CREATE OR REPLACE PROCEDURE proc_pub
IS
    CURSOR pub_cur IS
    SELECT publisher, sum(saleprice) AS total
        FROM book, orders
     WHERE BOOK.BOOKID = ORDERS.BOOKID
     GROUP BY publisher;
     p_publisher varchar2(100) :='';
     p_total number(9) :=0;
BEGIN
    OPEN pub_cur;
    LOOP
        FETCH pub_cur INTO p_publisher, p_total;
        exit WHEN pub_cur%NOTFOUND;
        dbms_output.put_line('publisher : ' || p_publisher || ', total saleprice : ' || p_total);
    END LOOP;
    COMMIT;
    CLOSE pub_cur;
END;

���)
SQL> exec proc_pub;
publisher : �½�����, total saleprice : 20000
publisher : �̻�̵��, total saleprice : 46000
publisher : ������, total saleprice : 12000
publisher : ���ѹ̵��, total saleprice : 21000
publisher : Pearson, total saleprice : 19000

PL/SQL ó���� ���������� �Ϸ�Ǿ����ϴ�.

--2.3 ���ǻ纰�� ������ ��հ����� ��� ������ �̸��� ���̽ÿ�(���� ��� A ���ǻ� ������ ��հ��� 20,000���̶�� A���ǻ� ���� �� 20000�� �̻��� ������ ���̸� ��)

CREATE OR REPLACE PROCEDURE proc_price
IS
    CURSOR price_cur IS
    SELECT publisher, bookname
        FROM book
     WHERE price > ( SELECT avg(price) FROM book GROUP BY publisher);
     p_publisher varchar2(100):='';
     p_bookname varchar2(100):='';
BEGIN
    OPEN price_cur;
    LOOP
        FETCH price_cur INTO p_publisher, p_bookname;
        exit WHEN price_cur%NOTFOUND;
        dbms_output.put_line('publisher : '||p_publisher||', ��հ����� ��� bookname : '||p_bookname);
    END LOOP;
    CLOSE price_cur;
END;

--2.4 ������ ������ �� �� �����ߴ����� �ѱ��ž��� ���̽ÿ�

--2.5 �ֹ��� �ִ� ���� �̸��� �ֹ� �Ѿ��� ����ϰ�, �ֹ��� ���� ���� �̸��� ����ϴ� ���ν����� �ۼ�


--3. ���� PL/SQL �Լ��� �ۼ��Ͻÿ� DB�� ���缭�� �̿�


--3.1 ���� �ֹ� �Ѿ��� ����Ͽ� 20000�� �̻��̸� '���' 20000�� �̸��̸� '����'�� ��ȯ�ϴ� �Լ� Grade()�� �ۼ��Ͻÿ�. 

--Grade()�� ȣ���Ͽ� ���� �̸��� ����� ���̴� SQL�� �ۼ��Ͻÿ�


--3.2 �����ּҸ� �̿��Ͽ� ������ �����ϸ� '��������', �ؿܿ� �����ϸ� '���ܰ���'�� ��ȯ�ϴ� �Լ� Domestic()�� �ۼ��Ͻÿ�.

--Domestic()�� ȣ���Ͽ� �� �̸��� ����/���� ���� ���θ� ����ϴ� SQL���� �ۼ��Ͻÿ�


--3.3 '3.2' ���� �ۼ��� Domestic()�� ȣ���Ͽ� �������� ���� �Ǹ� �Ѿװ� ���ܰ��� ���� �Ǹ��Ѿ��� ����ϴ� SQL���� �ۼ��Ͻÿ�
