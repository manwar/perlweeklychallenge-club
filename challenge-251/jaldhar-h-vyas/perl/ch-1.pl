#!/usr/bin/perl
use 5.030;
use warnings;

my $total = 0;

while (scalar @ARGV > 1) {
    $total += shift . pop;
}

if (scalar @ARGV) {
    $total += $ARGV[0];
}

say $total;
