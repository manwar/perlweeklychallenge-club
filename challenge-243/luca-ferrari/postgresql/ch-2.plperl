--
-- Perl Weekly Challenge 243
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-243/>
--

CREATE SCHEMA IF NOT EXISTS pwc243;

CREATE OR REPLACE FUNCTION
pwc243.task2_plperl( int[])
RETURNS int
AS $CODE$

   my ( $nums ) = @_;
   my $sum = 0;
   
   for my $current ( $nums->@* ) {
       for my $value ( map { int( $current / $_ ) } $nums->@* ) {
       	   $sum += $value;
       }
   }

   return $sum;
$CODE$
LANGUAGE plperl;
