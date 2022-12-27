-- Perl Weekly Challenge 197
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc197;

/*
estdb=> select pwc197.task1_plperl( array[1,2,3,0,4,5,0,9,0,10]::int[] );
      task1_plperl      
------------------------
 {1,2,3,4,5,9,10,0,0,0}

*/

CREATE OR REPLACE FUNCTION
pwc197.task1_plperl( int[] )
RETURNS int[]
AS $CODE$
my ( $list ) = @_;
my @sorted = ( grep( { $_ != 0 } $list->@* ),
               grep( { $_ == 0 } $list->@* ) );
return [ @sorted ];	       
$CODE$
LANGUAGE plperl;
