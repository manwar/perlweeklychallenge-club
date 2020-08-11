#!/usr/bin/perl

use strict;
use warnings;

my @L = (-25, -10, -7, -3, 2, 4, 8, 10);
my $S = $#L;
my $T = 0;

foreach my $i (0 .. $S) {
    foreach my $j (0 .. $S) {
        next if ($i == $j);
        foreach my $k (0 .. $S) {
            next if (($k == $i) || ($k == $j));
            print sprintf("[%d, %d, %d]\n", $L[$i], $L[$j], $L[$k])
                if ($L[$i] + $L[$j] + $L[$k] == $T);
        }
    }
}
