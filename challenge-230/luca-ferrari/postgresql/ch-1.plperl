--
-- Perl Weekly Challenge 230
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-230/>
--

CREATE SCHEMA IF NOT EXISTS pwc230;

CREATE OR REPLACE FUNCTION
pwc230.task1_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $nums ) = @_;

   for ( $nums->@* ) {
       for ( split //, $_ ) {
       	   return_next( $_ );
       }
   }

   return undef;
$CODE$
LANGUAGE plperl;
