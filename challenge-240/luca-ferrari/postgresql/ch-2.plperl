--
-- Perl Weekly Challenge 240
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-240/>
--

CREATE SCHEMA IF NOT EXISTS pwc240;

CREATE OR REPLACE FUNCTION
pwc240.task2_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $numbers ) = @_;

   for ( 0 .. $numbers->@* ) {
       return_next( $numbers->[ $numbers->[ $_ ] ] );
   }

   return undef;
$CODE$
LANGUAGE plperl;
