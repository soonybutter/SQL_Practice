-- CREATE : 데이터 베이스의 객체를 생성하는 DDL

-- 제약조건
-- UNIQUE: 중복 허용 X
-- NOT NULL : NULL 받을 수 없다.
-- CHECK :  특정 범위 값만 허용.
-- PRIMARY KEY : UNIQUE+NOT NULL 
--               한개의 테이블에 하나만 존재.
-- FOREIGN KEY : 다른 테이블의 값을 참조. 기본키, 유니트 제약조건이 걸려있는 컬럼만 참조가능.

-- DML(데이터 조작언어) --
-- INSERT, UPDATE, DELETE, SELECT(DQL) --
-- [CRUD] --
-- C(CREATE) : INSERT / 데이터 추가
-- R(READ)   : SELECT / 데이터 조회
-- U(UPDATE) : UPDATE / 데이터 수정
-- D(DELETE) : DELETE / 데이터 삭제


-- INSERT : 새로운 행을 특정 테이블에 추가하는 명령어
--          실행 후에는 테이블의 ROW(행)가 증가한다.

-- INSERT INTO 테이블명[(컬럼명,컬럼명 ,, 명시 가능! )] VALUES(값, 값, ...);

-- 컬럼을 명시하여 데이터 추가
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY,
                     BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
                     VALUES(500, '김철수','800101-1234567','ttss@naver.com','01023442222','D1','J7','S4',
                     3100000,0.1,'200',CURRENT_DATE,NULL,DEFAULT);
                     
SELECT * FROM EMPLOYEE
WHERE EMP_ID =500;


-- 컬럼을 명시하지 않고 데이터 추가(모든 컬럼에 값을 추가)
INSERT INTO EMPLOYEE
VALUES(900,'김철수','660101-2345678','KIMFF@naver.com','01022222222','D1','J7','S3','4300000',0.2,'200',
       CURRENT_DATE,NULL,DEFAULT);
      
SELECT * FROM EMPLOYEE
WHERE EMP_ID IN(500,900);

-- INSERT + SUBQUERY
-- VALUES 대신 SUBQUERY로 값을 지정하여 추가
CREATE TABLE EMP_01(
	EMP_ID NUMBER,
	EMP_NAME VARCHAR2(20),
	DEPT_TITLE VARCHAR2(40)
);

SELECT * FROM EMP_01;

INSERT INTO EMP_01(
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE
	FROM EMPLOYEE
	LEFT JO
	
	IN DEPARTMENT ON(DEPT_CODE=DEPT_ID) 

);

DROP TABLE EMP_01;

-- UPDATE : 해당 테이블의 데이터를 수정하는 명령어
-- UPDATE 테이블 SET 컬럼명 = 수정할 값, 컬럼명 = 수정할 값,...
-- [WHERE 조건]

-- UPDATE 실행 후 데이터의 수는 (ROW의 개수) 변하지 않는다.

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- D9 부서를 총무부 -> 전략기획부 
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획부'
WHERE DEPT_ID ='D9';

COMMIT ; -- 반영
ROLLBACK; -- 취소

--
CREATE TABLE TEST_EMP
AS SELECT * FROM EMPLOYEE;
-- EMPLOYEE 테이블에서 주민번호가 잘못 표기되어 있는 사원이 있다.
-- '621230', '631126', '850705' 로 변경하는 UPDATE 구문 3개 작성

-- 1. 잘못 표기된 사원 조회
-- 사번 : 
SELECT * FROM TEST_EMP;
-- 2. UPDATE
UPDATE TEST_EMP SET EMP_NO = '621230' || SUBSTR(EMP_NO,7)
WHERE EMP_ID = 200;

UPDATE EMPLOYEE SET EMP_NO = '621230' || SUBSTR(EMP_NO,7)
WHERE EMP_ID = 200;

UPDATE EMPLOYEE SET EMP_NO = '631126' || SUBSTR(EMP_NO,7)
WHERE EMP_ID = 201;

UPDATE EMPLOYEE SET EMP_NO = '850705' || SUBSTR(EMP_NO,7)
WHERE EMP_ID = 214;

SELECT EMP_ID, EMP_NO
FROM EMPLOYEE
WHERE EMP_ID  IN (200,201,214);

-- UPDATE + SUBQUERY
-- UPDATE 테이블명 SET 컬럼명 =(서브쿼리)

CREATE TABLE EMP_SALARY
AS 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;


-- 유재식 사원과 같은 급여와 보너스를 받게끔
-- 방명수 사원의 급여 보너스를 수정.

SELECT * FROM EMP_SALARY WHERE EMP_NAME='유재식';
-- 1000, 0.8
UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY FROM EMP_SALARY WHERE EMP_NAME='유재식'),
	BONUS = (SELECT BONUS FROM EMP_SALARY WHERE EMP_NAME='유재식')
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_SALARY;

-- 정중하, 전형돈 사원의 급여, 보너스도 유재식과 동일하게

-- 다중열 서브쿼리
UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT SALARY,BONUS FROM EMP_SALARY WHERE EMP_NAME='유재식')
WHERE EMP_NAME IN ('정중하','전형돈');

SELECT * FROM EMP_SALARY
WHERE EMP_NAME IN ('유재식','방명수','정중하','전형돈');


-- 아시아 지역에 근무하는 직원들의 보너스를 0.25로 수정.

-- 서브쿼리
SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

--
UPDATE EMP_SALARY SET BONUS = 0.25
WHERE EMP_ID IN(
	SELECT EMP_ID
	FROM EMP_SALARY
	JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
	JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
	WHERE LOCAL_NAME LIKE 'ASIA%'
);

SELECT * FROM EMP_SALARY;

UPDATE EMPLOYEE
SET DEPT_CODE = 'D0'
WHERE DEPT_CODE = 'D6';


-- DELETE
-- 테이블의 행을 삭제하는 명령어 수행하고 나면 테이블의 행의 개수가 줄어든다.
-- DELETE FORM 테이블명 [WHERE 조건]
-- WHERE 조건을 작성하지 않고 실행하면 모든 정보가 삭제....

CREATE TABLE TEST_DELETE
AS SELECT * FROM EMPLOYEE;

--전체 삭제
DELETE FROM TEST_DELETE;
SELECT * FROM TEST_DELETE;

SELECT * FROM EMP_SALARY;
-- EMP_SALARY 에서 BONUS를 0.25만큼 받지 않는 사원 삭제
DELETE FROM EMP_SALARY;


-- ALTER --
DROP TABLE DEPT_COPY;

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_COPY 테이블에 컬럼 추가
ALTER TABLE DEPT_COPY
ADD(LNAME VARCHAR2(20));

SELECT * FROM DEPT_COPY;


-- 컬럼 삭제
ALTER TABLE DEPT_COPY DROP COLUMN LNAME;

SELECT * FROM DEPT_COPY;

-- 테이블에 기본값을 적용하여 컬럼 추가
ALTER TABLE DEPT_COPY
ADD(LNAME VARCHAR2(20) DEFAULT '한국');

SELECT * FROM DEPT_COPY;

-- 컬럼에 제약조건 추가하기
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_COPY2에
-- PK, UNIQUE, NOTNULL 추가해보기

ALTER TABLE DEPT_COPY2
ADD CONSTRAINT PK_DEPT_CP2 PRIMARY KEY(DEPT_ID);

ALTER TABLE DEPT_COPY2
ADD CONSTRAINTS UK_DEPT_CP2 UNIQUE(DEPT_TITLE);

ALTER TABLE DEPT_COPY2
MODIFY LNAME CONSTRAINT NN_DEPT_LNAME NOT NULL;

SELECT * FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'DEPT_COPY2';

SELECT * FROM USER_CONSTRAINTS
WHERE TABLE_NAME ='DEPT_COPY2';

SELECT * FROM DEPT_COPY2;

INSERT INTO DEPT_COPY2 VALUES('D9', '샘플부서','L1','한국'); -- 오류 (중복)
INSERT INTO DEPT_COPY2 VALUES('D10', '샘플부서','L1','한국'); -- 오류 (D10이 넘 크다)

-- 컬럼 수정
ALTER TABLE DEPT_COPY2
MODIFY DEPT_ID CHAR(3)
MODIFY DEPT_TITLE VARCHAR(30)
MODIFY LOCATION_ID VARCHAR(2)
MODIFY LNAME CHAR(20);

INSERT INTO DEPT_COPY2 VALUES('D10','샘플부서','L1','한국');

-- DEPT TITLE 컬럼을 수정 -> VARCHAR2(10)

ALTER TABLE DEPT_COPY2
MODIFY DEPT_TITLE VARCHAR2(10); -- 오류 (값이 너무 크다)

-- DEFAULT 추가
ALTER TABLE DEPT_COPY2
MODIFY LNAME VARCHAR2(20) DEFAULT '대한민국';

INSERT INTO DEPT_COPY2 VALUES('D11','개발팀','L1',DEFAULT);
SELECT * FROM DEPT_COPY2;

-- 컬럼의 이름 변경
ALTER TABLE DEPT_COPY2
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT * FROM DEPT_COPY2;


-- 테이블의 이름 변경
ALTER TABLE DEPT_COPY2
RENAME TO DEPT_COPY_TWO;

SELECT * FROM DEPT_COPY_TWO;
SELECT * FROM DEPT_COPY2; -- 이름 바꿔서 얘는 없는애가 됨..


-- 테이블 한정으로 RENAME 간략하게 작성가능
RENAME DEPT_COPY_TWO TO DEPT_COPY2;


----------------------------------------------------

-- TCL
-- CONTROL
-- 제어언어
-- COMMIT, ROLLBACK ...

-- 트랜잭션 : 데이터 처리하는 최소의 작업 단위
-- 모두 성공 OR 모두 실패..
-- COMMIT(저장/반영), ROLLBACK(취소)

-- COMMIT : 트랜잭션이 종료될때 정상적으로 종료되었다면 변경한 사항을 영구히 DB에 저장
-- ROLLBACK : 트랜잭션 작업 중 오류가 발생할 경우 작업한 내역을 취소(복구).
--           가장 최근에 COMMIT 했던 시점으로 ROLLBACK;

COMMIT;

CREATE TABLE USER_TBL(
	NO NUMBER UNIQUE,
	ID VARCHAR2(20) NOT NULL UNIQUE,
	PW VARCHAR2(20) NOT NULL
);

SELECT * FROM USER_TBL;

ROLLBACK;
-- 테이블 생성 후 ROLLBACK을 하더라도 생성된 테이블이 사라지지는 않는다.

INSERT INTO USER_TBL VALUES(1,'TEST01','PASS01');
INSERT INTO USER_TBL VALUES(2,'TEST02','PASS02');

SELECT * FROM USER_TBL;
COMMIT; -- 여기까지 작업한 DML 내역을 DB에 반영.

INSERT INTO USER_TBL VALUES(3, 'TEST03','PASS03');
SELECT * FROM USER_TBL;

ROLLBACK; -- 가장 최근에 COMMIT한 시점으로 되돌아감.


INSERT INTO USER_TBL VALUES(3, 'TEST03','PASS03');
INSERT INTO USER_TBL VALUES(4, 'TEST04','PASS04');
INSERT INTO USER_TBL VALUES(5, 'TEST05','PASS05');
INSERT INTO USER_TBL VALUES(6, 'TEST06','PASS06');

---------------------------------------------
-- DDL 명령어는 트랜젝션의 개념이 아니다.
-- COMMIT/ ROLLBACK 불가능
-- 또한 이전 DML(INSERT, UPDATE,..)을 실행 후
-- DDL 명령어 사용하면 이전까지의 데이터 조작 내용이 자동 COMMIT  처리 된다.


























































































































































































































