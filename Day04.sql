-- JOIN --
-- 두 개 이상 테이블의 결과를 하나의 테이블 형태로 합쳐서 사용하는 방법

SELECT *
FROM EMPLOYEE;

-- 만약에 'J6'직급을 가진 사원들의 근무 부서명이 궁금하다
SELECT EMP_NAME, JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6';

SELECT *
FROM DEPARTMENT 
WHERE DEPT_ID IN ('D1', 'D8');

-- 표준문법--
-- 조인하고자 하는 테이블을 FROM 다음에 JOIN 테이블명 으로 작성해 하나로 합친다!

SELECT EMP_ID, EMP_NAME,JOB_CODE,DEPT_TITLE 
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- EMPLOYEE 테이블에 DEPARTMENT 테이블을 JOIN한다. 
-- EMPLOYEE의 DEPT_CODE 와 DEPARTMETN의 DEPT_ID가 같은 것끼리 합친다.


SELECT EMP_ID, EMP_NAME,JOB_CODE,DEPT_TITLE 
FROM EMPLOYEE
--JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN DEPARTMENT ON(EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID)
WHERE JOB_CODE = 'J6';


-- ORACLE 문법 --
-- FROM 구문에 , 로 구문하여 합치게 될 테이블을 나열하고
-- WHERE 절에 합칠 테이블들의 공통사항을 작성하여 조건을 나열한다.

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;


-- 컬럼명이 동일할때
SELECT * FROM EMPLOYEE;
SELECT * FROM JOB;

-- ㄴ 명시해주거나 별칭을 통한 명시해줘야함 !
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

SELECT *
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- ORACLE 문법
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE ;


-- DEPARTMENT 테이블의 위치정보와
-- LOCATION 테이블을 조인하여 각 부서별 근무지 위치를 조회
-- 부서코드, 부서명, 근무지 코드, 근무지 위치

-- 연결하고자 하는 테이블 조회
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;



-- INNER JOIN / OUTER JOIN
-- 테이블을 JOIN 통해 하나로 합칠때
-- INNER JOIN은 둘 모두 일치하는 데이터만 합치고
-- OUTER JOIN 은 둘 중 하나, 혹은 둘 모두가 가진 데이터들을 합친다.

-- INNERJOIN
-- JOIN을 했을때 EMPLOYEE테이블 DEPT_CODE 컬럼에 NULL인 데이터는 사라진다.
SELECT DISTINCT DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
ORDER BY 1;

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE
ORDER BY 1;

SELECT  * FROM DEPARTMENT d ;

-- OUTER JOIN --
-- LEFT [OUTER] JOIN : 두 테이블 중 원본테이블의 정보를 모두 포함하여 조회할때 선언
-- RIGHT [OUTER] JOIN : 두 테이블 중 JOIN에 명시한 테이블의 정보를 모두 포함하여 조회할때 선언. 
-- FULL [OUTER] JOIN : 두 테이블이 가진 데이터 중 서로가 가지지 않은 값일 지라도 모두 포함하여 조회.


SELECT DEPT_CODE, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


-- LEFT JOIN --
SELECT DEPT_CODE, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT *
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


-- RIGHT JOIN --
SELECT DEPT_CODE, DEPT_ID, EMP_NAME
FROM EMPLOYEE 
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT *
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


--FULL JOIN --
SELECT DEPT_CODE, DEPT_ID, EMP_NAME
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


-- ON() 안에 들어가는 형식이 컬럼 뿐만이 아니라
-- 계산식, 함수식, AND, OR 조건식 등을 다양하게 넣을 수 있다.

-- NON-EQUAL JOIN
-- 지정한 컬럼 값 자체가 아닌 특정 범위 내에 존재하는 조건으로 JOIN을 수행
SELECT * FROM SAL_GRADE sg ;
SELECT * FROM EMPLOYEE;


SELECT EMP_NAME, DEPT_CODE, SALARY, EMPLOYEE.SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);

-- SELF JOIN --
-- 자기 자신을 조인하는 방법
SELECT E.EMP_ID "사번",
       E.EMP_NAME "사원명",
       E.MANAGER_ID "관리자 사번",
       M.EMP_NAME "관리자명",
       M.PHONE "관리자 전화번호"
FROM EMPLOYEE E
JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);


SELECT * FROM EMPLOYEE;


-- 다중 JOIN --
-- 여러개의 테이블을 JOIN
-- 앞서 조인한 결과를 기준으로 이후에 조인할 테이블을 연결.
-- 조인 순서에 주의.

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;


SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);

-- 직급이 대리이면서 아시아 지역에서 근무하는 사원 조회
-- 사번, 사원명, 직급명, 부서명, 근무지역명, 급여
-- ON(A=B AND C='대리')
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY 
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '대리')
JOIN DEPARTMENT D ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON(LOCATION_ID = LOCAL_CODE AND LOCAL_NAME LIKE 'ASIA%');


SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY 
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON(LOCATION_ID = LOCAL_CODE)
WHERE JOB_NAME = '대리' AND LOCAL_NAME LIKE 'ASIA%';

-- 한국(KO)과 일본(JP)에 근문하는 직원들의 정보 조회
-- 사원명, 부서명, 지역명, 국가명
-- NATIONAL 테이블 활용
SELECT EMP_NAME 사원명, DEPT_TITLE 부서명, LOCAL_NAME 지역명, NATIONAL_NAME 국가명
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION L ON(LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE )
WHERE NATIONAL_NAME IN('한국','일본');


-- Sub Query --
-- 주가 되는 메인 쿼리 안에 조건이나 하나의 검색을 위한 또 다른 쿼리를 추가

-- 최소 급여를 받는 사원의 정보 조회
SELECT MIN(SALARY) FROM EMPLOYEE;
SELECT * FROM EMPLOYEE WHERE SALARY = 1380000;

SELECT *
FROM EMPLOYEE
WHERE SALARY =(SELECT MIN(SALARY) FROM EMPLOYEE );


-- 다중행 서브쿼리
-- 결과값이 여러줄
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;


-- 직급 별 최소급여를 받는 직원의 정보를 조회하자
SELECT *
FROM EMPLOYEE
--WHERE SALARY = 220000 OR SALARY 2000000
--WHERE SALARY IN(2200000,2000000,3400000);
WHERE SALARY IN(SELECT MIN(SALARY)
                FROM EMPLOYEE
                GROUP BY JOB_CODE);

SELECT * FROM EMPLOYEE;



-- 다중행 다중열 서브쿼리--
-- 여러 컬럼과 여러줄의 결과를 가지는 서브쿼리를 사용하여 조회.

SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN(SELECT JOB_CODE, MIN(SALARY) 
FROM EMPLOYEE
GROUP BY JOB_CODE);



-- 퇴사한 여직원과 같은 직급, 같은 부서에 근무하는 직원 정보 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE ENT_YN = 'Y';


SELECT * FROM EMPLOYEE
WHERE(DEPT_CODE, JOB_CODE)=(SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE ENT_YN ='Y')
AND EMP_ID  != (SELECT EMP_ID
FROM EMPLOYEE
WHERE ENT_YN = 'Y');

--
SELECT * FROM EMPLOYEE
WHERE DEPT_CODE =(SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT_YN='Y')
AND JOB_CODE =(SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN='Y')
AND EMP_ID  <> (SELECT EMP_ID FROM EMPLOYEE WHERE ENT_YN='Y');


-- 서브쿼리 사용 위치
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, JOIN..
-- DML: INSERT, UPDATE, DELETE
-- DDL: CREATE TABS, CREATE VIEW

-- FROM 위치에 사용하는 서브쿼리
-- INLINE VIEW(인라인 뷰)
-- 테이블을 명으로 직접 조회하는 대신
-- 서브쿼리의 결과셋(ResultSet)을 활용하여 조회가능.


-- 인라인 뷰를 활용한 데이터 조회
SELECT *
FROM(
SELECT EMP_ID 아이디, EMP_NAME 이름, DEPT_TITLE 부서, JOB_NAME 직급
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN JOB USING(JOB_CODE)
);


-- 가장 많이 팔린 책 상위 5개
-- 가장 많이 주문된 음식 상위 3개

-- ROWNUM : 데이터를 조회할때 각 행의 번호를 매겨주는 함수
SELECT EMP_NAME, SALARY
FROM EMPLOYEE;


SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM<6;

-- 급여 기준으로 가장 높은 급여를 받는 사원 상위 5명 조회.
-- 사번, 사원명, 급여를 출력

SELECT ROWNUM, EMP_ID, ENP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

-- ROWNUM은 FROM에서 실행할때 번호가 매겨진다.
SELECT ROWNUM, A. *
FROM
( 
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC
)A
WHERE ROWNUM < 6;



-- RANK() 함수 , DENSE_RANK() 함수

SELECT EMP_NAME, SALARY,
       RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;

SELECT *
FROM
(
SELECT EMP_NAME, SALARY,
       RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE
)
WHERE 순위 < 4;

SELECT EMP_NAME, SALARY,
       DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;
WHERE 순위 < 4;

-- DENS_RANK() : 동일한 순번이 있을 경우 이후 순번에 영향을 미치지 않는다.
--1
--2
--3
SELECT EMP_NAME, SALARY,
       DENSE_RANK () OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;



-- 상호 연관 쿼리: 상관쿼리
-- 일반적으로 서브쿼리 서브쿼리대로, 메인쿼리 서브쿼리의 결과만을 받아서 실행.
-- 메인 쿼리가 사용하는 컬럼값, 계산 등을 서브쿼리에 적용하여 서브쿼리 실행 시
-- 메인 쿼리의 값도 함께 사용하는 방식

-- 사원의 직급에 따른 급여 평균보다 많이받는 사원의 정보를 조회..
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > (
                SELECT AVG(SALARY)
                FROM EMPLOYEE E2
                WHERE E.JOB_CODE = E2.JOB_CODE
               );
              
SELECT * FROM EMPLOYEE;


--SELECT에 서브쿼리
-- 모든 사원의 사번, 사원명, 관리자 사번, 관리자 명을 조회.
SELECT EMP_ID, EMP_NAME, MANAGER_ID,
      (SELECT EMP_NAME FROM EMPLOYEE M WHERE E.MANAGER_ID=M.EMP_ID) "관리자 이름"
FROM EMPLOYEE E;

SELECT CONCAT(EMP_NAME, EMP_ID)
FROM EMPLOYEE;

-- 자신이 속한 직급의 평균 급여보다 많이 받는 사원의 이름(EMP_NAME), 직급명(JON_NAME), 급여정보(SALARY) 조회
SELECT EMP_NAME 이름, JOB_NAME 직급명, SALARY 급여
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE SALARY > (
SELECT AVG(SALARY)
FROM EMPLOYEE E2
WHERE E.JOB_CODE  = E2.JOB_CODE
);


-- ----------------------------
-- CREATE : 데이터베이스의 객체를 생성하는 DDL
-- CREATE 객체 객체명(관련 내용...)

-- 계정 생성
-- CREATE USER MULTI IDENTIFIED BY MULTI

-- CREATE TABLE TEST(
-- 컬럼명 자료형(길이) 제약조건
-- );

-- 테이블 생성 -- 
-- 데이터를 지정하기 위한 표, 틀( 객체)
-- 데이터를 2차원의 표 형태로 담을 수 있는 객체다.

/*
 * 제약조건 : 테이블에 데이터를 저장하고자 할 때 지켜야 하는 규칙
 * NOT NULL - NULL값을 허용하지 않는다.(필수입력사항)
 * UNIQUE - 중복값을 허용하지 않는다.
 * CHECK - 지정한 이력사항 외에는 값을 저장하지 못하게 막는 조건. (미리 지정한 값만 입력받겠다.)
 * PRIMARY KEY - (NOT NULL + UNIQUE)
 *               테이블 내에서 해당하는 행을 인식할 수 있는 고유값.
 *               테이블 내에서 단 1개만 존재.
 * FOREIGN KEY - 다른 테이블에서 저장된 값을 연결 지어서 참조로 가져오는 데이터에 지정하는 제약조건.
 * 
 * */











































































       













































































































            
               
               
               
               





























































































































































































