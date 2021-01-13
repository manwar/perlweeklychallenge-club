-- 
-- For the table definition, see the file ch-1.table
--
-- The numbers in @N are stored in Numbers, one number per row.
-- The target $A is the value for the place holder in the query.
--

SELECT  COUNT(*)
  FROM (SELECT  1
          FROM  Numbers t1,
                Numbers t2
         WHERE  t1.id   != t2.id
           AND  t1.value - t2.value = ?
        LIMIT 1)
