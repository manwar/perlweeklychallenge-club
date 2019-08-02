#!/usr/bin/env perl6

use v6;

#| Given a starting an ending year print all months in the years between (inclusive) with 5 weekends (Friday, Saturday and Sunday)
multi sub MAIN(
    Int() $start = 1900, #= Starting year. Defaults to 1900
    Int() $end = Date.today().year() #= Ending year. Default to this year.
) {
    say "Months with 5 Fridays between {$start} and {$end}";

    for $start..$end -> $year {
        for 1..12 -> $month {
            my $range = Date.new( :$year, :$month, :1day )..Date.new( :$year, :$month, day => Date.new( :$year, :$month ).days-in-month );
            my @weekends = (5..7).map( -> $dow { $range.grep( *.day-of-week == $dow  ).elems } );
            say "{$year}-{sprintf("%02d",$month)}" if all( @weekends ) == 5;
        }
    }
}

#| Display help text
multi sub MAIN(
    Bool :h(:$help) where ?*
) {
    say $*USAGE;
}
