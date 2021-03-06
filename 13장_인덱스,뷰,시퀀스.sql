--13장

--13-1 
SELECT * FROM DICT;

--13-3 계정이 가지고있는 테이블이름을 알고싶을때유용
SELECT
  TABLE_NAME  
FROM USER_TABLES;

--13-7
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT';





--인덱스 INDEX

--13-8 현재 계정이 소유한 인덱스 정보 확인
SELECT * FROM USER_INDEXES;

--인덱스 생성
CREATE INDEX IDX_EMP_SAL
ON EMP(SAL); --EMP테이블의 SAL열



--인덱스 확인하기
SELECT 

      TABLE_NAME     테이블명,
      INDEX_NAME   인덱스이름,
      COLUMN_NAME   컬럼이름
FROM ALL_IND_COLUMNS 
WHERE TABLE_NAME = 'MEMBERS';


----
CREATE TABLE members(
    member_id INT,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    gender CHAR(1) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR2(255) NOT NULL,
    PRIMARY KEY(member_id)--기본키 설정
);
SELECT * FROM MEMBERS;


SELECT * FROM members
WHERE last_name = 'Harse';

--아래 셀렉트문을 설명문으로 만듬
EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name = 'Harse';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
    
    
    
--인덱스 만들기
CREATE INDEX MEMBERS_LAST_NAME_I
ON MEMBERS(LAST_NAME);


EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name = 'Harse';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
    
    
--인덱스 삭제
DROP INDEX MEMBERS_LAST_NAME_I;




--뷰 VIEW

--13-15 뷰생성
CREATE VIEW VW_EMP20
 AS (SELECT EMPNO,ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO=20);

--가상테이블이지만 실제테이블처럼 사용가능
SELECT * FROM VW_EMP20; 

--복습
CREATE VIEW VM_EMP30ALL
 AS(SELECT * FROM EMP WHERE DEPTNO = 30);

--뷰삭제 : 뷰를 삭제해도 실제 테이블은 삭제 되지않는다.
DROP VIEW VW_EMP20;


--뷰생성 OR REPLACE 사용
CREATE OR REPLACE VIEW VW_EMP
 AS (SELECT EMPNO,ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO=10);
 
 




--시퀀스 : 증가한 시퀀스 값은 다시 돌리수없음, 삭제후 다시 생성해야함

--시퀀스 생성
CREATE SEQUENCE 시퀀스1;

--시퀀스 삭제
DROP SEQUENCE 시퀀스1;

--시퀀스 확인
SELECT * FROM USER_SEQUENCES;

--시퀀스 테스트용 테이블

DROP TABLE 테스트;

CREATE TABLE 테스트(
  번호 NUMBER PRIMARY KEY,--기본키
  부서이름 VARCHAR2(100)
  );

SELECT * FROM 테스트;

--시퀀스 사용시 -> 시퀀스명.NEXTVAL : 값이 증가하여 출력됨
INSERT INTO 테스트 ( 번호,부서이름) VALUES(시퀀스1.NEXTVAL,'영업부');
INSERT INTO 테스트 ( 번호,부서이름) VALUES(시퀀스1.NEXTVAL,'개발부');
INSERT INTO 테스트 ( 번호,부서이름) VALUES(시퀀스1.NEXTVAL,'IT부');


--테스트용 듀얼 테이블
SELECT SYSDATE FROM DUAL; --오라클DB에서 만들어진 테스트용 테이블
--현재값에서 증가하여 출력됨
SELECT 시퀀스1.NEXTVAL FROM DUAL;

--증가하지않고 현재 시퀀스 값출력
SELECT 시퀀스1.CURRVAL FROM DUAL;


--시퀀스생성
CREATE SEQUENCE 시퀀스2
START WITH 10  --시작값 10
INCREMENT BY 20; -- 증가 20

INSERT INTO 테스트 ( 번호,부서이름) VALUES(시퀀스2.NEXTVAL,'마케팅부');
INSERT INTO 테스트 ( 번호,부서이름) VALUES(시퀀스2.NEXTVAL,'교육부');
INSERT INTO 테스트 ( 번호,부서이름) VALUES(시퀀스2.NEXTVAL,'개발부');

--새로운 시퀀스로 UPDATE 하기
CREATE SEQUENCE 시퀀스3
START WITH 100000
INCREMENT BY 10;

UPDATE 테스트
SET 번호 = 시퀀스3.NEXTVAL;


DROP SEQUENCE 시퀀스1;
DROP SEQUENCE 시퀀스2;
DROP SEQUENCE 시퀀스3;
DROP TABLE 테스트;


--동의어
--동의어 생성
CREATE SYNONYM E FOR EMP;

DROP SYNONYM E;
SELECT * FROM E;



--연습문제

--1
CREATE TABLE EMPIDX
 AS SELECT * FROM EMP;

CREATE SEQUENCE IDX_EMPIDX_EMPNO;

SELECT * FROM USER_SEQUENCES;

--2
CREATE VIEW EMPIDX_OVER15K
AS (SELECT EMPNO,ENAME,JOB,DEPTNO,SAL,NVL2(COMM,'O','X') AS COMM FROM EMP WHERE SAL>1500);

SELECT * FROM EMPIDX_OVER15K;
DROP VIEW EMPIDX_OVER15K;



--3
CREATE TABLE DEPTSEQ
AS(SELECT * FROM DEPT);

CREATE SEQUENCE DEPTSEQ_DEPTNO 
START WITH 1
INCREMENT BY 1
MAXVALUE 99
MINVALUE 1
NOCYCLE
NOCACHE;

INSERT INTO DEPTSEQ(DEPTNO,DNAME,LOC) VALUES(DEPTSEQ_DEPTNO.NEXTVAL,'DATABASE','SEOUL');
INSERT INTO DEPTSEQ(DEPTNO,DNAME,LOC) VALUES(DEPTSEQ_DEPTNO.NEXTVAL,'WEB','BUSAN');
INSERT INTO DEPTSEQ(DEPTNO,DNAME,LOC) VALUES(DEPTSEQ_DEPTNO.NEXTVAL,'MOBILE','ILSAN');

SELECT * FROM DEPTSEQ;


--EMP테이블에 COMM 값이없으면 0으로표시
SELECT EMPNO,ENAME,NVL(COMM,0) FROM EMP;