--
-- Perl Weekly Challenge 226
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-226/>
--

CREATE SCHEMA IF NOT EXISTS pwc226;

CREATE OR REPLACE FUNCTION
pwc226.task2_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $numbers ) = @_;
   my $moves = 0;

   # inner function to get the min value
   # non zero in the array 
   my $min = sub {
      my $min = undef;
      for ( $_[0]->@* ) {
      	  next if $_ == 0;
      	  $min = $_ if ! $min || $_ < $min;
      }

      return $min;      
   };

   # inner function to see if the array
   # if full of zeros
   my $is_empty = sub {
      my ( $array ) = @_;
      return scalar( grep( { $_ == 0 } $array->@* ) ) == scalar( $array->@* );
   };



   
   while ( ! $is_empty->( $numbers ) ) {
	 my $removing = $min->( $numbers );
	 $moves++;

	 for my $index ( 0 .. $numbers->@* ) {
	     next if $numbers->[ $index ] == 0;
	     $numbers->[ $index ] -= $removing;
	 }
   }


   return $moves;

$CODE$
LANGUAGE plperl;
