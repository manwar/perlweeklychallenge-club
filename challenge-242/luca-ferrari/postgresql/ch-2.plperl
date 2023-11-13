--
-- Perl Weekly Challenge 242
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-242/>
--

CREATE SCHEMA IF NOT EXISTS pwc242;

/*
testdb=> select * from  pwc242.task2_plperl( array[ array[1, 0, 0], array[ 0,1,0], array[0,0,1] ]);
       task2_plperl        
---------------------------
 {{1,1,0},{1,0,1},{0,1,1}}

*/
CREATE OR REPLACE FUNCTION
pwc242.task2_plperl( int[] )
RETURNS int[]
AS $CODE$
   my ( $matrix ) = @_;

   my $output;


   for my $row ( $matrix->@* ) {
       push $output->@*,
       	    [ map { $_ == 0 ? 1 : 0 } split( //, reverse( join( '', $row->@* ) ) ) ];

   }

   return $output;
$CODE$
LANGUAGE plperl;
