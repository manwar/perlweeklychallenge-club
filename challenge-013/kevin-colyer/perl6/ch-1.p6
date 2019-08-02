#!/usr/bin/perl6
use v6;
use Test;

# Challenge #13.1
# Write a script to print the date of last Friday of every month of a given year. Order y, m, d

my $year=2019;
for 1..12 -> $month {
    my $d=Date.new($year,$month,1);
    my $dim=$d.days-in-month -1;
    my $friday = $d + first {($d+$_).day-of-week==5}, $dim-7..$dim;
    say $friday.yyyy-mm-dd;
}
