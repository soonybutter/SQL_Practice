/*
> sql plus
사용자명 입력 : system
비밀번호 입력 : 1234

CREATE USER MULTI IDENTIFIED BY Test09061234 
DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;



-- 권한부여
GRANT CONNECT, RESOURCE TO MULTI;
-- GRANT DWROLE TO MULTI;

COMMIT;

> sql plus
사용자명 입력 : MULTI
비밀번호 입력 : MULTI

*/

/*
-- 실행 : CTRL + ENTER
drop user MULTI;

CREATE USER MULTI IDENTIFIED BY Test09061234 
DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- 권한부여
GRANT CONNECT, RESOURCE TO MULTI;
-- GRANT DWROLE TO MULTI;

COMMIT;
-- -----------------------------

SELECT * FROM TABS;

CREATE TABLE TEST_1( NAME VARCHAR2(30));

DROP TABLE TEST_1;

SELECT * FROM TEST_1;

INSERT INTO TEST_1 VALUES('LEE');
*/

--실행 : 커서를 실행하고자 하는 명령어에 두고 ctrl+ enter
--     실행하고자 하는 명령어를 블럭치고 alt + x ( 여러줄 실행도 가능 )
SELECT * FROM TABS;

-- 한줄 주석

/*여러줄
 * 주
 * 석
 **/
