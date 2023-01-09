-- Perl Weekly Challenge 199
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc199;

/*
estdb=> select pwc199.task2_plperl( 7,2,3, array[3,0,1,1,9,7]::int[] );
 task2_plperl 
--------------
            4

*/
CREATE OR REPLACE FUNCTION
pwc199.task2_plperl( int, int, int, int[] )
RETURNS int
AS $CODE$
  my ( $x, $y, $z, $list ) = @_;
  my @triplets;

  for my $i ( 0 .. $list->@* ) {
    for my $j ( $i + 1 .. $list->@* - 1 ) {
      for my $k ( $j + 1 .. $list->@* - 2 ) {

        push @triplets, [ $i, $j, $k ] if ( abs( $list->[ $i ] - $list->[ $j ] ) <= $x
	                                 && abs( $list->[ $j ] - $list->[ $k ] ) <= $y
					 && abs( $list->[ $i ] - $list->[ $k ] ) <= $z );
      }
    }
  }


  return scalar @triplets;
$CODE$
LANGUAGE plperl;
