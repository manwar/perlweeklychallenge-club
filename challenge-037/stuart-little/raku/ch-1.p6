#!/usr/bin/env perl6
use v6;

sub nr_weekdays(Int $year, Int $month where 1 <= * <= 12) {
    ((my $date=Date.new($year,$month,1))..$date.last-date-in-month).grep({ $_.day-of-week == (1..5).any }).elems
}

my $year=(@*ARGS) ?? (@*ARGS[0].Int) !! (DateTime.now.year);

say $year;
for (1..12).map({ $_ => nr_weekdays($year,$_) }) {.say}

# run as <script> <year; defaults to current year>
