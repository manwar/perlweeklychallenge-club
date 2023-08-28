--
-- Perl Weekly Challenge 231
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-231/>
--

CREATE SCHEMA IF NOT EXISTS pwc231;

CREATE OR REPLACE FUNCTION
pwc231.task1_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $nums ) = @_;

   my $min = sub {
      my ( $array ) = @_;
      my $min = undef;

      for ( $array->@* ) {
      	  $min = $_ if ( not defined( $min ) || $_ < $min );
      }

      return $min;
   };


   my $max = sub {
      my ( $array ) = @_;
      my $max = $array->[ 0 ];
      for ( $array->@* ) {
      	  $max = $_ if ( $_ > $max );
      }

      return $max;
   };


   my ( $min_value, $max_value ) = ( $min->( $nums ), $max->( $nums ) );
   for ( $nums->@* ) {
       return_next( $_ ) if ( $_ > $min_value && $_ < $max_value );
   }

   return undef;


$CODE$
LANGUAGE plperl;
