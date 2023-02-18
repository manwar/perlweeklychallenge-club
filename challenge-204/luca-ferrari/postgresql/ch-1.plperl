--
-- Perl Weekly Challenge 204
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-204/>
--

CREATE SCHEMA IF NOT EXISTS pwc204;

CREATE OR REPLACE FUNCTION
pwc204.task1_plperl( int[] )
RETURNS int
AS $CODE$
 my ( $list ) = @_;
 my $monotonic_type;

 for ( 1 .. scalar( $list->@* ) - 1 ) {
   next if ( $list->[ $_ ] == $list->[ $_ - 1 ] );
   
   if ( ! defined( $monotonic_type ) ) {
      $monotonic_type = ( $list->[ $_ ] > $list->[ $_ - 1 ] ) ? 1 : 0;
   }

   return 0 if ( $monotonic_type && $list->[ $_ ] < $list->[ $_ - 1 ] );
   return 0 if ( ! $monotonic_type && $list->[ $_ ] > $list->[ $_ - 1 ] );
 }

 return 1;

$CODE$
LANGUAGE plperl;
