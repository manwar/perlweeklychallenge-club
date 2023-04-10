--
-- Perl Weekly Challenge 211
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-211/>
--

CREATE SCHEMA IF NOT EXISTS pwc211;

/*
estdb=# select pwc211.task2_plperl( array[ 1,2,3,4,5,6,7,8] );
 task2_plperl 
--------------
 {1,2,7,8}
 {3,4,5,6}
(2 rows)

*/
CREATE OR REPLACE FUNCTION
pwc211.task2_plperl( int[] )
RETURNS SETOF int[]
AS $CODE$
   use List::Permutor;
   use List::Util qw/sum/;
   my ( $array ) = @_;

   my $permutator   = List::Permutor->new( $array->@* );
   while ( my @current = $permutator->next ) {
     my ( $split_at ) = ( $#current + 1) / 2;
     my ( $left, $right ) = ( [ @current[ 0 .. ( $split_at - 1 ) ] ], [ @current[ $split_at .. $#current ] ] );

     if ( ( sum( $left->@* ) / scalar( $left->@* ) ) == ( sum( $right->@* ) / scalar( $right->@* ) ) ) {
     	return_next( $left );
	return_next( $right );
	return undef;
     }
   }

return undef;
$CODE$
LANGUAGE plperlu;
