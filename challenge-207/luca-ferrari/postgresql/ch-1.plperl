--
-- Perl Weekly Challenge 207
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-207/>
--

CREATE SCHEMA IF NOT EXISTS pwc207;

CREATE OR REPLACE FUNCTION
pwc207.task1_plperl( text[] )
RETURNS SETOF text
AS $CODE$

   my ( $words ) = @_;
   my ( @keyboard ) = qw/ qwertyuiop asdfghjkl zxcvbnm /;

   for my $current_word ( $words->@* ) {
       for my $current_row ( @keyboard ) {
       	   my $found = 0;
	   for my $current_letter ( split( '', lc( $current_word ) ) ) {
	       $found++ if ( $current_row =~ /$current_letter/ );
	   }

	   if ( scalar( split( '', $current_word ) ) == $found ) {
	      return_next( $current_word );
	      last;
	   }
       }
   }

   return undef;

$CODE$
LANGUAGE plperl;
