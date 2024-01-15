--
-- Perl Weekly Challenge 252
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-252/>
--

CREATE SCHEMA IF NOT EXISTS pwc252;

CREATE OR REPLACE FUNCTION
pwc252.task2_plperl( int )
RETURNS SETOF int
AS $CODE$
   my ( $size ) = @_;

   die "Cannot have a size less than 3!" if ( $size <= 3 );

   if ( $size % 2 == 0 ) {
      for ( 1 .. $size / 2 ) {
      	  return_next( $_ );
	  return_next( $_ * -1 );
      }
   }
   else {
       for ( 1 .. ( $size - 1 ) / 2 ) {
      	  return_next( $_ );
	  return_next( $_ * -1 );
      }

      my $next = int( $size / 2 ) + 1;
      return_next( $next );
      return_next( $next + 1 );
      return_next( ( $next + $next + 1 ) * -1 );
   }

return undef;
$CODE$
LANGUAGE plperl;
