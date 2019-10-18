#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub isLeap {
    my ($year) = @_;

    # years divisible by 100 are not leap years unless they are divisble by 400.
    return ($year % 4 == 0 && ($year % 100 != 0 || $year % 400 == 0));
}

my $newYearDay = 3;
for my $year (2020 .. 2101) {
    if ($newYearDay % 7 == 0) {
        say $year - 1, '-12-25';
    }
    $newYearDay += (isLeap($year)) ? 2 : 1;
}