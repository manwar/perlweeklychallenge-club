--
-- Perl Weekly Challenge 206
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-206/>
--

CREATE SCHEMA IF NOT EXISTS pwc206;

CREATE OR REPLACE FUNCTION
pwc206.task1_plperl( text[] )
RETURNS int
AS $CODE$
   my ( $times ) = @_;
   my $computations = {};
   my $min;

   my $diff = sub {
      my ( $start, $end ) = @_;
      $start =~ /^(\d{2}):(\d{2})$/;
      my ( $start_hours, $start_mins ) = ( $1, $2 );

      $end =~ /^(\d{2}):(\d{2})$/;
      my ( $end_hours, $end_mins ) = ( $1, $2 );

      if ( $start_hours == 0) {
      	 $start_hours = 23;
	 $start_mins += 60;
      }

      if ( $end_hours == 0) {
      	 $end_hours = 23;
	 $end_mins += 60;
      }

      return abs( $end_hours - $start_hours ) * 60 + abs( $end_mins - $start_mins ) % 60;
   };


   for my $begin ( sort $times->@* ) {
       for my $end ( sort $times->@* ) {
       	   next if ( $begin eq $end );

	   my $difference = $diff->( $end, $begin );
	   $computations->{ $difference } = [ $begin, $end ];
	   $min = $difference if ( ! $min || $difference < $min );
       }
   }

   elog(INFO, "Min is $min minutes from " . join( ',', $computations->{ $min }->@* ) );
   return $min;
$CODE$
LANGUAGE plperl;
