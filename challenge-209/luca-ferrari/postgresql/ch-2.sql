--
-- Perl Weekly Challenge 209
-- Task 2
--
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-209/>
--

CREATE SCHEMA IF NOT EXISTS pwc209;

DROP TABLE IF EXISTS pwc209.accounts;
CREATE TABLE IF NOT EXISTS pwc209.accounts ( a_name text, a_email text );
TRUNCATE TABLE pwc209.accounts;
INSERT INTO pwc209.accounts
VALUES ( 'A', 'a1@a.com' )
, ('A', 'a2@a.com' )
, ( 'B', 'b@b.com'  )
, ( 'A', 'a3@a.com' )
, ( 'A', 'a1@a.com'  );


CREATE OR REPLACE FUNCTION
pwc209.task2_plpgsql()
RETURNS TABLE( a text, e text )
AS $CODE$

WITH duplicated_emails AS ( SELECT a_email FROM pwc209.accounts GROUP BY a_email HAVING COUNT(*) > 1 )
, duplicated_accounts AS ( SELECT a_name FROM pwc209.accounts WHERE a_email IN ( SELECT a_email FROM duplicated_emails ) )
SELECT distinct( a_name, a_email )
FROM pwc209.accounts WHERE a_name IN ( SELECT a_name FROM duplicated_accounts );
$CODE$
LANGUAGE sql;
