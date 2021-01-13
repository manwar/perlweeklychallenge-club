#!/usr/bin/env perl

use v5.26;
use warnings;

use Time::Local;

for (my $year = 2000; $year <= 2999; $year++) {
    my ($day, $month) = (reverse $year) =~ /(..)(..)/;
    eval { timegm(0, 0, 0, $day, $month - 1, $year - 1900) };
    if (! $@) {
        say reverse($year) . $year;
    }
}