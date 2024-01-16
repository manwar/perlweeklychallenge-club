--
-- Perl Weekly Challenge 250
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-250/>
--

CREATE SCHEMA IF NOT EXISTS pwc250;

CREATE OR REPLACE FUNCTION
pwc250.task1_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $nums ) = @_;

   for  ( 0 .. $nums->@* - 1 ) {
       return $_ if ( ( $_ % 10 ) == $nums->@[ $_ ] );
   }

   return -1;
$CODE$
LANGUAGE plperl;
