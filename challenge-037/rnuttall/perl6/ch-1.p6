#!/usr/bin/env perl6
# Task1 : Write a script to calculate the total number of weekdays (Mon-Fri) in each month of the year 2019.

use v6;
use DateTime::Format;

sub MAIN(Int() $year = Date.today().year()) {
    for 1..12 -> $month {
        my $d    = DateTime.new(year => $year, month => $month, day => 1);
        say strftime('%b', $d) ~ ": " ~
                map({Date.new(2019, $month, $_).day-of-week()},1 .. $d.days-in-month())
                .grep({$_ <= 5})
                .elems;
    }
}
