--
-- Perl Weekly Challenge 239
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-239/>
--

CREATE SCHEMA IF NOT EXISTS pwc239;

/*
testdb=> select pwc239.task1_plperl( array['a','bc'], array['ab','c'] );
 task1_plperl 
--------------
 t
(1 row)

testdb=> select pwc239.task1_plperl( array['a','bc'], array['ab','c', 'd'] );
 task1_plperl 
--------------
 f
*/
CREATE OR REPLACE FUNCTION
pwc239.task1_plperl( text[], text[] )
RETURNS bool
AS $CODE$
   my ( $words1, $words2 ) = @_;

   return 1 if ( join('', $words1->@*) eq join( '', $words2->@* ) );
   return 0;
$CODE$
LANGUAGE plperl;
