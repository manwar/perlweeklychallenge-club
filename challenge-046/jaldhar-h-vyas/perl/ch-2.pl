#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

my @rooms = (0) x 500;
my $end = scalar @rooms - 1;

for my $i (0 .. $end) {
    for my $j (0 .. $end) {
        if (($j + 1) % ($i + 1) == 0) {
            $rooms[$j] = ($rooms[$j]) ? 0 : 1;
        }
    }
}

for my $i (0 .. $end) {
    if ($rooms[$i]) {
        print $i + 1, q{ };
    }
}
print "\n";