-- Perl Weekly Challenge 191
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc191;


/*
testdb=> select * from pwc191.task1_plperl( ARRAY[1,2,3,6]::int[] );
 task1_plperl 
--------------
            1

*/
CREATE OR REPLACE FUNCTION
pwc191.task1_plperl( int[] )
RETURNS int
AS $CODE$
   my ($l) = @_;

   my $max = 0;

   # compute the max element
   for ( $l->@* ) {
       $max = $_ if ( $max < $_ );
   }

   # iterate on all elements and see
   # if one of the is doubly greater than the max
   for ( $l->@* ) {
       next if $_ == $max;
       return -1 if $_ * 2 > $max;
   }

   return 1;
$CODE$
LANGUAGE plperl;
