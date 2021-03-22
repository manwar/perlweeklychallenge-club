-- 
-- Run as: <database client> < ch-1.sql
-- after you've added the appropriate INSERT statements
-- before the SELECT statement.
--

CREATE TABLE Input (
    N  DOUBLE  NOT NULL,
    k  DOUBLE  NOT NULL
);

SELECT  POW (k, 1 / N)
  FROM  Input

