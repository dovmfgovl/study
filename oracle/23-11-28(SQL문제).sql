/*<TOAD_FILE_CHUNK>*/

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


--[예제 5-3] Book 테이블에 저장된 도서의 평균가격을 반환하는 프로시저를 작성하시오.

CREATE OR REPLACE PROCEDURE proc_avg
IS
    avg_price number(10);
BEGIN
    SELECT avg(price) INTO avg_price
        FROM book;
        dbms_output.put_line('도서의 평균가격은 '|| avg_price ||'원 입니다.');
END;
/

/*<TOAD_FILE_CHUNK>*/
--[예제 5-4] Orders 테이블의 판매 도서에 대한 이익을 계산하는 프로시저를 작성하시오.

CREATE OR REPLACE PROCEDURE proc_profit
IS
    profit_price number(10);
BEGIN
    SELECT sum(saleprice) INTO profit_price
        FROM orders;
        dbms_output.put_line('판매 도서 이익은 '|| profit_price);
END;

--연습문제


--1. 다음 프로그램을 프로시저로 작성하고 실행하시오. DB는 마당서점을 이용

--1.1 고객을 새로 등록하는 InsertCustomer()프로시저를 작성하시오

CREATE OR REPLACE PROCEDURE proc_insertCustomer(p_custid IN number, p_name IN varchar2)
IS
BEGIN 
    INSERT INTO customer(custid, NAME) VALUES(p_custid, p_name);
    COMMIT;
END;

--1.2 새로운 도서를 삽입하는  BookInsertOrUpdate() 프로시저를 작성, 동일한 도서가 있다면 가격이 높은 것을 업데이트

CREATE OR REPLACE PROCEDURE proc_bookInsertOrUpdate(p_bookid IN number, p_bookname IN varchar2, p_price IN number)
IS
BEGIN
    --기존 레코드가 존재하는지 확인
    DECLARE
        p_count number;
    BEGIN 
        SELECT count(*) INTO p_count FROM book WHERE bookid = p_bookid;
        
        --존재하면 업데이트
        IF p_count > 0 THEN
             UPDATE book
                set price = p_price 
              WHERE bookid = p_bookid AND p_price > price;
         ELSE
            -- 존재하지 않으면 삽입
             INSERT INTO book(bookid, bookname, price) VALUES(p_bookid, p_bookname, p_price);
        END IF;
      END;
    COMMIT;
END;

--2. 다음 프로그램을 프로시저로 작성하고 실행하시오. DB는 마당서점을 이용

--2.1 출판사가 '이상미디어' 인 도서의 이름과 가격을 보여주는 프로시저를 작성
-- 여러 도서가 있는 경우 , 하나의 행만 출력하는 프리시저

CREATE OR REPLACE PROCEDURE proc_publisher(p_publisher IN varchar2, msg OUT varchar2)
IS
     bookname varchar2(100);
     price number(9);
BEGIN
    SELECT bookname, price INTO bookname, price
        FROM book
     WHERE publisher = p_publisher AND ROWNUM = 1; -- 최초 하나의 행만 선택
     --선택된 행이 있는지 확인 . 없으면 메시지 출력되도록 설정
     IF SQL%FOUND THEN
        COMMIT;        
        msg := p_publisher ||'출판사의 도서는 '|| bookname ||'이고, 가격은 '|| price || '원 이다.';
     ELSE
        msg := p_publisher || ' 출판사의 도서가 존재하지 않습니다.';
     END IF;
END;

-- 여러 도서가 있는 경우, 모든 행을 출력하는 프리시저 -> bookname과 price가 출력 안 됨.....

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
         msg := p_publisher ||'출판사의 도서는 '|| bookname ||'이고, 가격은 '|| price || '원 이다.';
     END LOOP;
     --선택된 행이 있는지 확인 . 없으면 메시지 출력되도록 설정
     IF SQL%FOUND THEN 
        msg := p_publisher || ' 출판사의 도서가 존재하지 않습니다.';
     END IF;
END;

-- 여러 도서가 있는 경우, 모든 행을 출력하는 refcursor 프리시저

CREATE OR REPLACE PROCEDURE proc_publisher3(rc_publisher OUT sys_refcursor)
IS
BEGIN
    OPEN rc_publisher
    FOR SELECT bookname, price FROM book WHERE publisher = '이상미디어';
END;

출력) 
SQL> variable rc_publisher refcursor;
SQL> exec proc_publisher3(:rc_publisher);

PL/SQL 처리가 정상적으로 완료되었습니다.

SQL> print rc_publisher;

BOOKNAME                                      PRICE
---------------------------------------- ----------
야구의 추억                           20000
야구를 부탁해                         13000

--2.2 출판사별로 출판사 이름과 도서의 판매 총액을 보이시오(Orders 테이블 이용)
--cursor 사용: SELECT문이 여러 행을 반환할 수 있을 때, 커서를 사용하여 각 행을 반복적으로 처리한다.

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

출력)
SQL> exec proc_pub;
publisher : 굿스포츠, total saleprice : 20000
publisher : 이상미디어, total saleprice : 46000
publisher : 나무수, total saleprice : 12000
publisher : 대한미디어, total saleprice : 21000
publisher : Pearson, total saleprice : 19000

PL/SQL 처리가 정상적으로 완료되었습니다.

--2.3 출판사별로 도서의 평균가보다 비싼 도서의 이름을 보이시오(예를 들어 A 출판사 도서의 평균가가 20,000원이라면 A출판사 도서 중 20000원 이상인 도서를 보이면 됨)

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
        dbms_output.put_line('publisher : '||p_publisher||', 평균가보다 비싼 bookname : '||p_bookname);
    END LOOP;
    CLOSE price_cur;
END;

--2.4 고객별로 도서를 몇 권 구입했는지와 총구매액을 보이시오

--2.5 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성


--3. 다음 PL/SQL 함수를 작성하시오 DB는 마당서점 이용


--3.1 고객의 주문 총액을 계산하여 20000원 이상이면 '우수' 20000원 미만이면 '보통'을 반환하는 함수 Grade()를 작성하시오. 

--Grade()를 호출하여 고객의 이름과 등급을 보이는 SQL도 작성하시오


--3.2 고객의주소를 이용하여 국내에 거주하면 '국내거주', 해외에 거주하면 '국외거주'를 반환하는 함수 Domestic()을 작성하시오.

--Domestic()을 호출하여 고객 이름과 국내/국외 거주 여부를 출력하는 SQL문도 작성하시오


--3.3 '3.2' 에서 작성한 Domestic()을 호출하여 국내거주 고객의 판매 총액과 국외거주 고객의 판매총액을 출력하는 SQL문을 작성하시오
