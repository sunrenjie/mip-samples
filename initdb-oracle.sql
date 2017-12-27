/* Note that we are using the TEST1 PDB; search and replace if necessary*/

CREATE TABLE TEST1.PET (
    ID NUMBER(5,0) NOT NULL,
    NAME VARCHAR2(75),
    OWNER VARCHAR2(75),
    SPECIES VARCHAR2(75),
    SEX CHAR(1),
    BIRTH DATE,
    DEATH DATE,
    CONSTRAINT PET_ID_PK PRIMARY KEY (ID)
    USING INDEX
)
/

CREATE SEQUENCE TEST1.PET_ID_SEQ
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER
/

INSERT INTO TEST1.PET VALUES (TEST1.PET_ID_SEQ.nextval, 'Puffball','Diane','hamster','f', sysdate, NULL);
INSERT INTO TEST1.PET VALUES (TEST1.PET_ID_SEQ.nextval, 'Fluffy', 'Harold','cat','f', sysdate, NULL);
INSERT INTO TEST1.PET VALUES (TEST1.PET_ID_SEQ.nextval, 'Slim', 'Dennis','snake','f', sysdate, NULL);

DROP PROCEDURE test1.read_pet;

CREATE OR REPLACE PROCEDURE test1.read_pet(in_name IN VARCHAR2,
    out_owner OUT VARCHAR2,
    out_species OUT VARCHAR2,
    out_sex OUT VARCHAR2,
    out_birth OUT DATE,
    out_death OUT DATE)
IS
BEGIN
	SELECT owner, species, sex, birth, death
	INTO out_owner, out_species, out_sex, out_birth, out_death
	FROM test1.pet
  WHERE name = in_name;
END;
/

DECLARE
    out_owner VARCHAR2(100);
    out_species VARCHAR2(100);
    out_sex VARCHAR2(100);
    out_birth DATE;
    out_death DATE;
BEGIN
   test1.read_pet('Slimmy', out_owner, out_species, out_sex, out_birth, out_death);

   DBMS_OUTPUT.PUT_LINE('out_owner :  ' || out_owner);
   DBMS_OUTPUT.PUT_LINE('out_species :  ' || out_species);
   DBMS_OUTPUT.PUT_LINE('out_sex :  ' || out_sex);
   DBMS_OUTPUT.PUT_LINE('out_birth :  ' || out_birth);
   DBMS_OUTPUT.PUT_LINE('out_death :  ' || out_death);
END;
/

CREATE OR REPLACE PROCEDURE test1.read_all_pets(c_allpets OUT SYS_REFCURSOR)
IS
BEGIN
  OPEN c_allpets FOR
  SELECT name, owner, species, sex, birth, death FROM test1.pet;
END;
/

CREATE OR REPLACE FUNCTION test1.get_pet_owner(in_name IN VARCHAR2) RETURN VARCHAR2 IS
   out_owner VARCHAR2(200);
BEGIN
   SELECT owner
   INTO out_owner
   FROM test1.pet where name = in_name;

   RETURN out_owner;
END;
/

CREATE TABLE TEST1.EMPLOYEE (
    EMPID NUMBER(5,0) NOT NULL,
    EMPNAME VARCHAR2(200),
    SALARY NUMBER(30,0),
    DEPTID NUMBER(5,0) NOT NULL,
    CONSTRAINT EMP_ID_PK PRIMARY KEY (EMPID)
    USING INDEX
)
/

CREATE TABLE TEST1.DEPT (
    DEPTID NUMBER(5,0) NOT NULL,
    DEPTNAME VARCHAR2(200),
    LOCNAME VARCHAR2(200),
    CONSTRAINT DEPT_ID_PK PRIMARY KEY (DEPTID)
    USING INDEX
)
/

ALTER TABLE TEST1.EMPLOYEE add constraint FK_EMP_DEPT FOREIGN KEY (DEPTID)
references TEST1.DEPT (DEPTID);

INSERT INTO TEST1.DEPT VALUES (1, 'IT', 'Arizona');
INSERT INTO TEST1.DEPT VALUES (2, 'Servicing', 'IOWA');
INSERT INTO TEST1.DEPT VALUES (3, 'Technology', 'TEXAS');

INSERT INTO TEST1.EMPLOYEE VALUES (101, 'John Smith', 10000, 1);
INSERT INTO TEST1.EMPLOYEE VALUES (102, 'John Sims', 10000, 2);
INSERT INTO TEST1.EMPLOYEE VALUES (103, 'John McCoy', 10000, 2);
INSERT INTO TEST1.EMPLOYEE VALUES (104, 'DeAnne Shaw', 10000, 3);
/

COMMIT
