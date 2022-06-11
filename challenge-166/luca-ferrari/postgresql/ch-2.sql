-- Perl Weekly Challenge 166
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc166;

WITH
dir_a(f) AS
(
   SELECT *
   FROM pg_ls_dir( '/tmp/dir_a', TRUE, false)
)
, dir_b(f) AS
(
SELECT *
FROM pg_ls_dir( '/tmp/dir_b', true, false)
)
, dir_c(f) AS
(
SELECT *
FROM pg_ls_dir( '/tmp/dir_c', true,false)
)
SELECT a.f as dir_a, b.f as dir_b, c.f as dir_c
FROM dir_a a
FULL OUTER JOIN dir_b b on a.f = b.f
FULL OUTER JOIN dir_c c on c.f = a.f
WHERE
a.f IS NULL
OR b.f IS NULL
OR c.f IS NULL
;
