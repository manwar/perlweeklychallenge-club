-- Perl Weekly Challenge 194
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc194;

CREATE OR REPLACE FUNCTION
pwc194.task2_plperl( text )
RETURNS int
AS $CODE$
  my ( $what ) = @_;

  my %counter;
  my ( $max, $min ) = ( 0, 0 );

  for ( split '', $what ) {
      $counter{ $_ }++;
      $min = $counter{ $_ } if ( ! $min || $min > $counter{ $_ } );
      $max = $counter{ $_ } if ( ! $max || $max < $counter{ $_ } );
  }

  return 0 if ( $max - $min != 1 );
  return 0 if ( grep( { $counter{ $_ } == $max }  keys %counter ) != 1 );
  return 1;

$CODE$
LANGUAGE plperl;
