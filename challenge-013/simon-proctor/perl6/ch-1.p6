#!/usr/bin/env perl6

use v6;

sub date-format( $date ) { sprintf "%04d/%02d/%02d", .year, .month, .day given $date ; }

#| Print a list of every friday in the given year
sub MAIN ( 
    Int() $year #= Year to list Fridays for.
) {
    say( date-format($_) ) for (Date.new( :$year, :1month, :1day )...Date.new( :$year, :12month, :31day ))
    ==> grep( *.day-of-week() == 5)
    ==> sort( { $^b <=> $^a } )
    ==> grep( { state $m = 13; if ( $_.month < $m ) { $m = $_.month;True } else { False } })
    ==> sort( * <=> * );
}