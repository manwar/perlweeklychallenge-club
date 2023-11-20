--
-- Perl Weekly Challenge 243
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-243/>
--

CREATE SCHEMA IF NOT EXISTS pwc243;

CREATE OR REPLACE FUNCTION
pwc243.task1_plperl( int[] )
RETURNS int
AS $CODE$

   my ( $nums ) = @_;
   my @pairs;
   
   for my $i ( 0 .. $nums->@* ) {
       for ( grep( { $nums->[ $i ] > 2 * $_  } $nums->@[ ( $i + 1 ) .. $nums->@* ] ) ) {
           push @pairs, [ $nums->[ $i ], $_ ] if $_;	 
       }
   }

   return scalar @pairs;
$CODE$
LANGUAGE plperl;
