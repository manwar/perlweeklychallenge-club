#!/usr/bin/raku

sub MAIN (
    Int $year #= a year
) {
    for 1..12 -> $month {
        my $lastDate = Date.new($year, $month, 1).last-date-in-month;
        say $lastDate - $lastDate.day-of-week % 7;
    }
}