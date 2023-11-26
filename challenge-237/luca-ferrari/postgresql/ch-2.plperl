--
-- Perl Weekly Challenge 237
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-237/>
--

CREATE SCHEMA IF NOT EXISTS pwc237;

CREATE OR REPLACE FUNCTION
pwc237.task2_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $nums ) = @_;

   my $permutations = {};

   use List::Permutor;
   my $engine = List::Permutor->new( $nums->@* );
   while ( my @current_permutation = $engine->next ) {
   	 for ( 0 .. $nums->@* ) {
	     if ( $nums->[ $_ ] > $current_permutation[ $_ ] ) {
	     	# stop here
		push $permutations->{ $_ }->@*, $current_permutation;
		last;
	     }
	 }
   }

   


   #seek the max key
   return ( sort keys $permutations->%* )[ -1 ];


$CODE$
LANGUAGE plperlu;
