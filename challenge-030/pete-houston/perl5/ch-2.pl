#!/usr/bin/env perl
use strict;
use warnings;

my $sum = 12;
for my $marker (0 .. $sum) {
    for my $iter ($marker .. $sum - $marker) {
        my @set = ($marker, $iter, $sum - $iter - $marker);
        next if $set[2] < $set[1];
        next unless grep { $_ % 2 == 0 } @set;
        print "@set\n";
    }
}

