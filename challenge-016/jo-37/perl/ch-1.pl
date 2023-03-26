#!/usr/bin/perl

use v5.16;
use warnings;
use List::Gen;
use List::UtilsBy 'max_by';

# Build a generator for 100 pie pieces.
my $parts = do {
    my $pie = 1;
    <1..100>->map(sub {
            my $part = $pie * $_ / 100;
            $pie -= $part;
            $part;
        }
    );
}->cache;

# Find the 1-based index of the maximum.
say scalar max_by {$parts->($_ - 1)} 1 .. 100;
