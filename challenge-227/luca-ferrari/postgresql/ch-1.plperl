--
-- Perl Weekly Challenge 227
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-227/>
--

CREATE SCHEMA IF NOT EXISTS pwc227;

CREATE OR REPLACE FUNCTION
pwc227.task1_plperl( int )
RETURNS int
AS $CODE$
   my ( $year ) = @_;
   my $fridays = 0;
   
   use DateTime;
   my $day = DateTime->new( year => $year, day => 13, month => 1 );
   while ( $day->month <= 12 && $day->year == $year ) {
   	 $fridays++ if ( $day->day_abbr eq 'Fri' );
	 $day->add(  months => 1  );
   }

   return $fridays;
$CODE$
LANGUAGE plperlu;
