--
--  See the file ch-1.table for the definition of the used table.
--
--  Assumes each number of the input is on a separate row.
-- 

SELECT COUNT(*) 
  FROM (SELECT  1
          FROM  Numbers t1,
                Numbers t2,
                Numbers t3
         WHERE  t1 . id > t2 . id 
           AND  t2 . id > t3 . id
           AND  1 < t1 . value + t2 . value + t3 . value
           AND      t1 . value + t2 . value + t3 . value < 2
         LIMIT  1)
