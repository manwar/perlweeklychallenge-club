-- Perl Weekly Challenge 191
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc191;

CREATE OR REPLACE FUNCTION
pwc191.task2_plperl( int )
RETURNS int
AS $CODE$
   use List::Permute::Limit qw(permute_iter permute);

   my ($n) = @_;
   my $cute_counter = 0;
   my @l = ( 1 .. $n );
   
   my @permutations = permute( items => [ @l ], nitems => $n );
   for my $current_list ( @permutations ) {

       my $is_cute = 1;		 
       for my $i ( 0 .. $current_list->@* ) {

       	   if ( $current_list->[ $i ] % ( $i + 1 ) != 0 ) {
	      $is_cute = 0;
	      last;
	   }
       }

       $cute_counter++ if ( $is_cute );

       $is_cute = 1;		 
       for my $i ( 0 .. $current_list->@* ) {

       	   if ( ( $i + 1 ) % $current_list->[ $i ]  != 0 ) {
	      $is_cute = 0;
	      last;
	   }
       }

       $cute_counter++ if ( $is_cute );
   }

   return $cute_counter;
$CODE$
LANGUAGE plperlu;
