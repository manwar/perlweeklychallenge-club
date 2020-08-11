#!/usr/bin/perl6
use v6;

use Test;

=begin pod

Task 37.1

Write a script to calculate the total number of weekdays (Mon-Fri) in each month of the year 2019.

Jan: 23 days
Feb: 20 days
Mar: 21 days
Apr: 22 days
May: 23 days
Jun: 20 days
Jul: 23 days
Aug: 22 days
Sep: 21 days
Oct: 23 days
Nov: 21 days
Dec: 22 days

=end pod

my @month-abbrv=<Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec>;


sub weekdays-in-month(DateTime $date) {
    my $count=0;
    for ^$date.days-in-month -> $day {
        $count++ unless $date.later(days => $day).day-of-week >= 6;
    }
    return $count;
}

for 1..12 -> $month {
    say sprintf "%s: %02d days", @month-abbrv[$month-1],  weekdays-in-month(DateTime.new(year => 2019, month=> $month, day => 1 ));
}
