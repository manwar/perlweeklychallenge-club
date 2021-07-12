#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <time>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub angl($h,$m) {
    my $rawDiff = abs(($h % 12)*30 + $m/2 - $m * 6);
    return ($rawDiff <= 180) ? ($rawDiff) : (360-$rawDiff);
}

say angl(split ":", $ARGV[0]);
