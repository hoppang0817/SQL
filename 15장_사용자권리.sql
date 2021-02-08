--15장
-- 새 사용자 존을 만들기 (비번1234)
CREATE USER JOHN IDENTIFIED BY 1234;

--계정비밀번호 변경
ALTER USER 계정명 IDENTIFIED BY 변경할비밀번호;


--데이터베이스 접속 권한 부여
--권한을 줄때 GRANT 권한이름 TO 계정
GRANT CREATE SESSION TO JOHN;

--테이블 만들수있는 권한 부여
GRANT CREATE TABLE TO JOHN;

--각 계정에 테이블을 저장할수있는 테이블스페이스(tablespace)가 필요
--테이블스페이스 생성
--테이블스페이스 저장 주소, 사이즈
-- 자동으로 5MB씩 용량 추가
CREATE TABLESPACE JOHNSPACE
DATAFILE 'C:\oraclexe\app\oracle\oradata\XE\JOHN.DBF' SIZE 10M 
AUTOEXTEND ON NEXT 5M;


--추가된 테이블스페이스를 존계정이 사용할수있게 권한 부여
ALTER USER JOHN DEFAULT TABLESPACE JOHNSPACE;
ALTER USER JOHN QUOTA UNLIMITED ON JOHNSPACE; --접근권한(무한대로)


--권한들의 모음인 롤(ROLE)을 존 계정에 부여
GRANT CONNECT,RESOURCE TO JOHN;
--관리자 권한 모음인 롤(ROLE)
--GRANT DBA TO 계정이름

--권한 제거 : REVOKE 권한이름 FROM 계정;
REVOKE CREATE TABLE FROM JOHN;
-- 권한의모음 ROLE제거
REVOKE RESOURCE FROM JOHN;


--계정삭제
--삭제하려는 계정을 접속해제 한후 삭제가능
DROP USER JOHN CASCADE;


--테이블스페이스 삭제
DROP TABLESPACE JOHNSPACE;



