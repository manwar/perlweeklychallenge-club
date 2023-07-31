--
-- Perl Weekly Challenge 228
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-228/>
--

CREATE SCHEMA IF NOT EXISTS pwc228;

CREATE OR REPLACE FUNCTION
pwc228.task1_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $array ) = @_;
   my $bag = {};

   # classify the elements
   $bag->{ $_ }++ for ( $array->@* );

   my ( @uniques ) = grep( { $bag->{ $_ } == 1 } keys( $bag->%* ) );
   my $sum = 0;
   $sum += $_ for ( @uniques );
   return $sum;
$CODE$
LANGUAGE plperl;
