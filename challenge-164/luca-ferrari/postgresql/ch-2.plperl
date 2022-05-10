-- Perl Weekly Challenge 164
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc164;

CREATE OR REPLACE FUNCTION
pwc164.task2_plperl( int )
RETURNS SETOF int
AS $CODE$
  my ( $limit ) = @_;

  my $is_happy = sub {
     my ( $num ) = @_;
     my $sum = $num;
     while ( $num > 10 ) {
             $sum = 0;
             $sum += $_ for map { $_ ** 2 }  split( //, $num );
             $num = $sum;
             $sum = 0;
    }

    return $num == 1;
  };

  for ( 10 .. 99999 ) {
      $limit-- and return_next( $_ )  if $is_happy->( $_ );
      last if $limit == 0;
  }

  return undef; 
$CODE$
LANGUAGE plperl;
