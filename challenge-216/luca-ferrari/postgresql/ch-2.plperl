--
-- Perl Weekly Challenge 216
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-216/>
--

CREATE SCHEMA IF NOT EXISTS pwc216;

CREATE OR REPLACE FUNCTION
pwc216.task2_plperl( text, text[] )
RETURNS TABLE ( sticker text, run int, letter text )
AS $CODE$
   my ( $needle, $words ) = @_;
   my $searching_for = {};

   # create the bag
   for ( split //, $needle ) {
       $searching_for->{ $_ }++;
   }

   my $run = 0;
   while ( grep( { $_ >= 1 } values( $searching_for->%* ) ) ) {
   	 $run++;
         my $found = 0;

	 for my $letter ( keys $searching_for->%* ) {
	     next if ! $searching_for->{ $letter };
       	     for my $word ( $words->@* ) {
	     	 if ( grep( { $_ eq $letter } split( //, $word ) ) ) {
		    $searching_for->{ $letter }--;
		    return_next( { run => $run, sticker => $word, letter => $letter } );
		    $found++;
		    last;
		 }
	     }


	 }

	 if ( ! $found ) {
	    elog(INFO, "Cannot find match with letter $letter in any word!" );
	    return undef;
	 }
   }

return undef;

$CODE$
LANGUAGE plperl;
