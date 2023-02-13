--
-- Perl Weekly Challenge 204
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-204/>
--

CREATE SCHEMA IF NOT EXISTS pwc204;

/*
testdb=> select pwc204.task2_plperl( 3, 2, array[ array[ 1,2,3]::int[], array[3,4,5]::int[] ]::int[] );
    task2_plperl     
---------------------
 {{1,2},{3,3},{4,5}}
(1 row)

*/
CREATE OR REPLACE FUNCTION
pwc204.task2_plperl( int, int, int[][] )
RETURNS int[][]
AS $CODE$
  my ( $r, $c, $matrix ) = @_;
  my @N;
  my @new_row;

  return undef if ( ( $r * $c ) < $matrix->@* * $matrix->[0]->@* );

  for my $row ( 0 .. scalar( $matrix->@* ) - 1 ) {
     for my $col ( 0 .. scalar( $matrix->[ $row ]->@* ) - 1 ) {
        push @new_row, $matrix->[ $row ]->[ $col ] if ( @new_row < $c );
	if ( @new_row == $c ) {
	   push @N, [ @new_row ];
	   @new_row = ();
	}
     }
  }

  return [ @N ];
$CODE$
LANGUAGE plperl;
