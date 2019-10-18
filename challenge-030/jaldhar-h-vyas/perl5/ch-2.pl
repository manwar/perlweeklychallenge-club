#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my %results;

for my $i (1 .. 10) {
    for my $j (1 .. (12 - $i - 1)) {
        my $k = 12 - $i - $j;
        $results{join q{ }, sort ($i, $j, $k)}++;
    }
}

say for sort keys %results;