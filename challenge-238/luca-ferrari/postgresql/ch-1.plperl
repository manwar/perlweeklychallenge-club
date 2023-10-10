--
-- Perl Weekly Challenge 238
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-238/>
--

CREATE SCHEMA IF NOT EXISTS pwc238;

CREATE OR REPLACE FUNCTION
pwc238.task1_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $nums ) = @_;

   for my $index ( 0 .. $nums->@* - 1 ) {
       my $sum = 0;

       $sum += $_ for ( $nums->@[ 0 .. $index ] );
       return_next( $sum );
   }

   return undef;
$CODE$
LANGUAGE plperl;
