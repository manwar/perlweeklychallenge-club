--
-- Perl Weekly Challenge 251
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-251/>
--

CREATE SCHEMA IF NOT EXISTS pwc251;

/**
 * example
 testdb=> select pwc251.task2_plperl( array[ [ 3,  7,  8],
                   [ 9, 11, 13],
                   [15, 16, 17]] );
 task2_plperl 
--------------
           15
(1 row)
*/
CREATE OR REPLACE FUNCTION
pwc251.task2_plperl( int[][] )
RETURNS int
AS $CODE$
   my ( $matrix ) = @_;

   my $max_col = undef;

   # search the max column value
   my @max_col_indexes;
   for my $col ( 0 .. $matrix->@[ 0 ]->@* - 1 ) {
       $max_col_index[ $col ] = undef;

       for my $row ( 0 .. $matrix->@* - 1 ) {
       	   $max_col_index[ $col ] = $matrix->@[ $row ]->[ $col ] if ( ! $max_col_index[ $col ] || $max_col_index[ $col ] < $matrix->@[ $row ]->[ $col ] );
       }
   }
   for my $row ( 0 .. $matrix->@* - 1 ) {
       for my $col ( 0 .. $matrix->@[ $row ]->@* - 1 ) {
       	   $max_col = $matrix->@[ $row ]->[ $col ] if ( ! $max_col || $max_col < $matrix->@[ $row ]->[ $col ] );
       }
   }

  for my $row ( 0 .. $matrix->@* - 1 ) {
      my $current_min = undef;
      my $current_min_index = 0;
      
     for my $col ( 0 .. $matrix->@[ $row ]->@* - 1 ) {
     	 if ( ! $current_min || $matrix->@[ $row ]->[ $col ] < $current_min ) {
	    $current_min = $matrix->@[ $row ]->[ $col ];
	    $current_min_index = $col;
	 }
     }

     if ( $current_min == $max_col_index[ $current_min_index ] ) {
     	return $current_min;
     }


  }

  return -1;

$CODE$
LANGUAGE plperl;
