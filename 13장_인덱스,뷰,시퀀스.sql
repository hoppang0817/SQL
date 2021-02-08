--13��

--13-1 
SELECT * FROM DICT;

--13-3 ������ �������ִ� ���̺��̸��� �˰����������
SELECT
  TABLE_NAME  
FROM USER_TABLES;

--13-7
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT';





--�ε��� INDEX

--13-8 ���� ������ ������ �ε��� ���� Ȯ��
SELECT * FROM USER_INDEXES;

--�ε��� ����
CREATE INDEX IDX_EMP_SAL
ON EMP(SAL); --EMP���̺��� SAL��



--�ε��� Ȯ���ϱ�
SELECT 

      TABLE_NAME     ���̺��,
      INDEX_NAME   �ε����̸�,
      COLUMN_NAME   �÷��̸�
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
    PRIMARY KEY(member_id)--�⺻Ű ����
);
SELECT * FROM MEMBERS;


SELECT * FROM members
WHERE last_name = 'Harse';

--�Ʒ� ����Ʈ���� �������� ����
EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name = 'Harse';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
    
    
    
--�ε��� �����
CREATE INDEX MEMBERS_LAST_NAME_I
ON MEMBERS(LAST_NAME);


EXPLAIN PLAN FOR
SELECT * FROM members
WHERE last_name = 'Harse';

SELECT 
    PLAN_TABLE_OUTPUT 
FROM 
    TABLE(DBMS_XPLAN.DISPLAY());
    
    
--�ε��� ����
DROP INDEX MEMBERS_LAST_NAME_I;




--�� VIEW

--13-15 �����
CREATE VIEW VW_EMP20
 AS (SELECT EMPNO,ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO=20);

--�������̺������� �������̺�ó�� ��밡��
SELECT * FROM VW_EMP20; 

--����
CREATE VIEW VM_EMP30ALL
 AS(SELECT * FROM EMP WHERE DEPTNO = 30);

--����� : �並 �����ص� ���� ���̺��� ���� �����ʴ´�.
DROP VIEW VW_EMP20;


--����� OR REPLACE ���
CREATE OR REPLACE VIEW VW_EMP
 AS (SELECT EMPNO,ENAME,JOB,DEPTNO FROM EMP WHERE DEPTNO=10);
 
 




--������ : ������ ������ ���� �ٽ� ����������, ������ �ٽ� �����ؾ���

--������ ����
CREATE SEQUENCE ������1;

--������ ����
DROP SEQUENCE ������1;

--������ Ȯ��
SELECT * FROM USER_SEQUENCES;

--������ �׽�Ʈ�� ���̺�

DROP TABLE �׽�Ʈ;

CREATE TABLE �׽�Ʈ(
  ��ȣ NUMBER PRIMARY KEY,--�⺻Ű
  �μ��̸� VARCHAR2(100)
  );

SELECT * FROM �׽�Ʈ;

--������ ���� -> ��������.NEXTVAL : ���� �����Ͽ� ��µ�
INSERT INTO �׽�Ʈ ( ��ȣ,�μ��̸�) VALUES(������1.NEXTVAL,'������');
INSERT INTO �׽�Ʈ ( ��ȣ,�μ��̸�) VALUES(������1.NEXTVAL,'���ߺ�');
INSERT INTO �׽�Ʈ ( ��ȣ,�μ��̸�) VALUES(������1.NEXTVAL,'IT��');


--�׽�Ʈ�� ��� ���̺�
SELECT SYSDATE FROM DUAL; --����ŬDB���� ������� �׽�Ʈ�� ���̺�
--���簪���� �����Ͽ� ��µ�
SELECT ������1.NEXTVAL FROM DUAL;

--���������ʰ� ���� ������ �����
SELECT ������1.CURRVAL FROM DUAL;


--����������
CREATE SEQUENCE ������2
START WITH 10  --���۰� 10
INCREMENT BY 20; -- ���� 20

INSERT INTO �׽�Ʈ ( ��ȣ,�μ��̸�) VALUES(������2.NEXTVAL,'�����ú�');
INSERT INTO �׽�Ʈ ( ��ȣ,�μ��̸�) VALUES(������2.NEXTVAL,'������');
INSERT INTO �׽�Ʈ ( ��ȣ,�μ��̸�) VALUES(������2.NEXTVAL,'���ߺ�');

--���ο� �������� UPDATE �ϱ�
CREATE SEQUENCE ������3
START WITH 100000
INCREMENT BY 10;

UPDATE �׽�Ʈ
SET ��ȣ = ������3.NEXTVAL;


DROP SEQUENCE ������1;
DROP SEQUENCE ������2;
DROP SEQUENCE ������3;
DROP TABLE �׽�Ʈ;


--���Ǿ�
--���Ǿ� ����
CREATE SYNONYM E FOR EMP;

DROP SYNONYM E;
SELECT * FROM E;



--��������

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


--EMP���̺� COMM ���̾����� 0����ǥ��
SELECT EMPNO,ENAME,NVL(COMM,0) FROM EMP;