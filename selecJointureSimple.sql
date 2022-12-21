--Sélectivité grande
--Sans optimisation avec l'indice FULL
SELECT /*+ FULL(T1) FULL(T2) */ COUNT(*) FROM T1, T2 WHERE T1.col1 = T2.col1
/

-- Avec un index secondaire sur T1.col2 ainsi que l’indice INDEX ou INDEX_FFS
DROP INDEX t1_idx;
/

DROP INDEX t2_idx;
/

CREATE INDEX t1_idx ON T1 (col1);
/

CREATE INDEX t2_idx ON T2 (col1);
/

SELECT /*+ USE_NL_WITH_INDEX(T1 T2) */ COUNT(*) FROM T1, T2 WHERE T1.col1 = T2.col1
/

-- Avec HASH CLUSTER
alter system set undo_management = manual scope=spfile;
/

DROP CLUSTER Grappe1 INCLUDING TABLES;
/

CREATE CLUSTER Grappe1 (col1 INTEGER)
    TABLESPACE users
    STORAGE ( INITIAL 250K     
              NEXT 50K
              MINEXTENTS 1     
              MAXEXTENTS 3
              PCTINCREASE 0 )
    HASH IS col1 
    HASHKEYS 150;
/

CREATE TABLE T2_CLUSTER
CLUSTER Grappe1(COL1)
AS SELECT T1.ID ID,
T1.COL1 COL1,
T1.COL2 COL2,
T1.COL3 COL3,
T2.ID ID_0,
T2.COL1 COL1_1 FROM T1, T2 WHERE T1.col1 = T2.col1
/

SELECT /*+ HASH(T1_CLUSTER) */ COUNT(*) FROM T1_CLUSTER WHERE T1_CLUSTER.col3=1
/

--Avec bitmap index
DROP BITMAP INDEX col3ix;
/

CREATE BITMAP INDEX col3ix
ON T1(T1.col3);
/

SELECT /*+ INDEX(T1 col3) */ COUNT(*) FROM T1 WHERE T1.col3=1
/
