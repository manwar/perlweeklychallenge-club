--
-- Perl Weekly Challenge 236
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-236/>
--

CREATE SCHEMA IF NOT EXISTS pwc236;

CREATE OR REPLACE FUNCTION
pwc236.task1_plperl( int[] )
RETURNS boolean
AS $CODE$
   my ( $cash ) = @_;

   my $remainder = {};

   for my $current_cash ( $cash->@* ) {
       $remainder->{ $current_cash }++;
       next if $current_cash == 5;

       if ( $current_cash == 10 ) {
       	  return 0 if ( $remainder->{ 5 } == 0 );
	  $remainder->{ 5 }--;
       }

       if ( $current_cash == 20 ) {
          if ( $remainder->{ 10 } > 0 && $remainder->{ 5 } > 0 ) {
	     $remainder->{ 5 }--;
	     $remainder->{ 10 }--;
	  }
	  elsif ( $remainder->{ 10 } == 0 && $remainder->{ 5 } >= 3 ) {
	     $remainder->{ 5 } -= 3;
	  }
	  else {
	    return 0;
	  }

			
       }

   }

   return 1;
$CODE$
LANGUAGE plperl;
