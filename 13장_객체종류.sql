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