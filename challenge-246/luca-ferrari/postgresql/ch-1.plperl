--
-- Perl Weekly Challenge 246
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-246/>
--

CREATE SCHEMA IF NOT EXISTS pwc246;

CREATE OR REPLACE FUNCTION
pwc246.task1_plperl()
RETURNS SETOF int
AS $CODE$
   my @lottery;

   while ( @lottery < 6 ) {
   	 my $value = int ( rand( 49 ) );
	 if ( ! grep( { $_ == $value } @lottery ) ) {
	    push @lottery, $value;
	    return_next( $value );
	 }
   }

   return undef;
$CODE$
LANGUAGE plperl;
