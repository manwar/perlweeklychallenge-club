-- Perl Weekly Challenge 196
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc196;

CREATE OR REPLACE FUNCTION
pwc196.task1_plperl( int[] )
RETURNS SETOF int[]
AS $CODE$

  my ( $array ) = $_[ 0 ];
  my $index = 1;

  while ( $index < $array->@* ) {
     my @triplet = ( $array->[ $index - 1 ], $array->[ $index ], $array->[ $index + 1 ] );
     $index += 2 and return_next( [ @triplet ] )  if ( $tripet[ 0 ] < $triplet[ 1 ]
                                && $triplet[ 1 ] < $triplet[ 2 ] );
     $index++;				
  }

return undef;

$CODE$
LANGUAGE plperl;
