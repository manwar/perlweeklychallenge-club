--
-- Perl Weekly Challenge 252
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-252/>
--

CREATE SCHEMA IF NOT EXISTS pwc252;

CREATE OR REPLACE FUNCTION
pwc252.task1_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $nums ) = @_;

   my ( $sum ) = 0;
   
   for ( 0 .. $nums->@* - 1 ) {
       next if $nums->@* % ( $_ + 1 ) != 0;
       $sum += $nums->@[ $_ ] ** 2;    
   }

   return( $sum );
$CODE$
LANGUAGE plperl;
