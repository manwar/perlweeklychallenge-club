--
-- Perl Weekly Challenge 215
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-215/>
--

CREATE SCHEMA IF NOT EXISTS pwc215;

CREATE OR REPLACE FUNCTION
pwc215.task2_plperl( int, int[] )
RETURNS int
AS $CODE$
   my ( $count, $digits ) = @_;
   my ( $done );

   while ( $count ) {
   	 $done = 0;
	 for ( 1 .. scalar( $digits->@* ) - 1 ) {
	     if ( $digits->[ $_ ] == 0
	     	&& $digits->[ $_ - 1 ] == 0
		&& $digits->[ $_ + 1 ] == 0 ) {
		$digits->[ $_ ] = 1;
		$done = 1;
		$count--;
		last;
	     }
	 }

	 last if ! $done;
   }

   return 1 if ! $count;
   return 0;
$CODE$
LANGUAGE plperl;
