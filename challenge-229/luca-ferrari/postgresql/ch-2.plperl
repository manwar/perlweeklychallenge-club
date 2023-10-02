--
-- Perl Weekly Challenge 229
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-229/>
--

CREATE SCHEMA IF NOT EXISTS pwc229;

CREATE OR REPLACE FUNCTION
pwc229.task2_plperl( int[], int[], int[] )
RETURNS SETOF int
AS $CODE$
   my $bag = {};

   for my $array ( @_ ) {
       my $uniq = {};
       for my $item ( $array->@* ) {
       	   $uniq->{ $item }++;
       	   $bag->{ $item }++ if ( $uniq->{ $item } == 1 );
       }
   }

   for my $item ( keys $bag->%* ) {
       return_next( $item ) if ( $bag->{ $item } >= 2 );
   }

   return undef;
$CODE$
LANGUAGE plperl;
