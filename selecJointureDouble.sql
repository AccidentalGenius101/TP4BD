--Sélectivité grande
--Sans optimisation avec l'indice FULL
SELECT /*+ FULL(T1)*/ COUNT(*) FROM T1 WHERE T1.col3=1
/

-- Avec un index secondaire sur T1.col2 ainsi que l’indice INDEX ou INDEX_FFS
DROP INDEX INDEXSECONDAIRE;
/
CREATE INDEX INDEXSECONDAIRE ON T1 (col3);
/
SELECT /*+ INDEX(T1 col2)*/ COUNT(*) FROM T1 WHERE T1.col3=1
/

-- Avec HASH CLUSTER
DROP CLUSTER Grappe1 INCLUDING TABLES;
/

CREATE CLUSTER Grappe1 (col3 INTEGER)
   SIZE 512 SINGLE TABLE HASHKEYS 500;
/

CREATE TABLE T1_CLUSTER
CLUSTER Grappe1(col3)
AS SELECT * FROM T1
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
