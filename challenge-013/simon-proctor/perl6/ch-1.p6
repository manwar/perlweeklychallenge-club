#!/usr/bin/env perl6

use v6;

sub date-format( $date ) { sprintf "%04d/%02d/%02d", .year, .month, .day given $date ; }

#| Print a list of every friday in the given year
sub MAIN ( 
    Int() $year #= Year to list Fridays for.
) {
    say( date-format( $_ ) ) for (Date.new( :2019year, :1month, :1day, formatter => &date-format )...Date.new( :2019year, :12month, :31day, formatter => &date-format )).grep( *.day-of-week() == 5);
}