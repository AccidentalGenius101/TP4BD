DROP TABLE T1
/

DROP TABLE T2
/

DROP TABLE T3
/

CREATE TABLE T1
(
  id   INTEGER,
  col1 INTEGER,
  col2 INTEGER,
  col3 INTEGER
)
/

CREATE TABLE T2
(
  id   INTEGER,
  col1 INTEGER
)
/

CREATE TABLE T3
(
  id    INTEGER,
  col11 INTEGER,
  col12 INTEGER
)
/
DECLARE

BEGIN  
  DBMS_RANDOM.seed (val => 0);
  
  FOR i IN 1..1000000 LOOP
    INSERT INTO T1 VALUES 
    (i,
     DBMS_RANDOM.value(1,10000),
     DBMS_RANDOM.value(1,100),
     DBMS_RANDOM.value(1,2)     
    );
  END LOOP;
  
  FOR j IN 1..1000000 LOOP
    INSERT INTO T2 VALUES 
    (j,
     DBMS_RANDOM.value(1,10000)
    );
  END LOOP;
  
  FOR k IN 1..10000 LOOP
    INSERT INTO T3 VALUES 
    (k,
     DBMS_RANDOM.value(1,100),
     DBMS_RANDOM.value(1,100)
    );
  END LOOP;
END;
/
-- Temps d'execution approximatif: 160 secondes