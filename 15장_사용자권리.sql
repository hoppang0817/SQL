--15��
-- �� ����� ���� ����� (���1234)
CREATE USER JOHN IDENTIFIED BY 1234;

--������й�ȣ ����
ALTER USER ������ IDENTIFIED BY �����Һ�й�ȣ;


--�����ͺ��̽� ���� ���� �ο�
--������ �ٶ� GRANT �����̸� TO ����
GRANT CREATE SESSION TO JOHN;

--���̺� ������ִ� ���� �ο�
GRANT CREATE TABLE TO JOHN;

--�� ������ ���̺��� �����Ҽ��ִ� ���̺����̽�(tablespace)�� �ʿ�
--���̺����̽� ����
--���̺����̽� ���� �ּ�, ������
-- �ڵ����� 5MB�� �뷮 �߰�
CREATE TABLESPACE JOHNSPACE
DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\JOHN.DBF' SIZE 10M 
AUTOEXTEND ON NEXT 5M;


--�߰��� ���̺����̽��� �������� ����Ҽ��ְ� ���� �ο�
ALTER USER JOHN DEFAULT TABLESPACE JOHNSPACE;
ALTER USER JOHN QUOTA UNLIMITED ON JOHNSPACE; --���ٱ���(���Ѵ��)


--���ѵ��� ������ ��(ROLE)�� �� ������ �ο�
GRANT CONNECT,RESOURCE TO JOHN;
--������ ���� ������ ��(ROLE)
--GRANT DBA TO �����̸�

--���� ���� : REVOKE �����̸� FROM ����;
REVOKE CREATE TABLE FROM JOHN;
-- �����Ǹ��� ROLE����
REVOKE RESOURCE FROM JOHN;


--��������
--�����Ϸ��� ������ �������� ���� ��������
DROP USER JOHN CASCADE;


--���̺����̽� ����
DROP TABLESPACE JOHNSPACE;



