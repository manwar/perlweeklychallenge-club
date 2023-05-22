--
-- Perl Weekly Challenge 217
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-217/>
--

CREATE SCHEMA IF NOT EXISTS pwc217;

CREATE OR REPLACE FUNCTION
pwc217.task1_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $array ) = @_;
   return ( sort( $array->@* ) )[ 3 ];
$CODE$
LANGUAGE plperl;
