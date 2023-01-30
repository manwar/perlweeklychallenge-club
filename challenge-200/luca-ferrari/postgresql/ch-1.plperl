--
-- Perl Weekly Challenge 200
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-200/>
--

CREATE SCHEMA IF NOT EXISTS pwc200;

CREATE OR REPLACE FUNCTION
pwc200.task1_plperl( int[] )
RETURNS SETOF int[]
AS $CODE$
  my ( $list ) = @_;
  my @slices;

  for my $center ( 1 .. $list->@* - 1 ) {
    for ( 1 .. $center ) {
    my ( $start, $end ) = ( $center - $_, $center + $_ );
        $start = 0 if $start < 0;
        $end = $list->@* - 1 if $end >= $list->@*;

        my @seeking = $list->@[ $start .. $end ];
        my $ok = 1;
	my $difference = undef;

        for ( 1 .. $#seeking ) {
	  $difference = $seeking[ $_ ] - $seeking[ $_ - 1 ] if ! defined( $difference );
    	  $ok = 0 and last if $seeking[ $_ ] - $seeking[ $_ - 1 ] != $difference;
        }

        return_next( [@seeking] ) if $ok and scalar( @seeking ) >= 3;
    }
  }

return;
$CODE$
LANGUAGE plperl;
