--
-- Perl Weekly Challenge 237
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-237/>
--

CREATE SCHEMA IF NOT EXISTS pwc237;

CREATE OR REPLACE FUNCTION
pwc237.task1_plperl( int, int, int, int )
RETURNS text
AS $CODE$
   my ( $year, $month, $weekday, $week ) = @_;
   my $current_week = 0;

   my $ord = { 1 => 'first', 2 => 'second', 3 => 'third' };
   $ord->{ $_ } = $_ . 'th' for ( 4 .. 31 );



   use DateTime;
   my $date = DateTime->new( year => $year, month => $month, day => 1 );

   while ( $date->year == $year && $date->month == $month ) {
   	 $current_week++ if ( $date->day_of_week == 1 );
	 if ( $current_week == $week && $date->day_of_week == $weekday ) {
	    # found
	    return sprintf 'The %s %s of month %s in %s is %d',
	    	   	   $ord->{ $current_week },
			   $date->day_abbr,
			   $date->month_abbr,
			   $date->year,
			   $date->day;
	 }

	 $date->add( days => 1 );
   }

   return 'Date not found';

$CODE$
LANGUAGE plperlu;
