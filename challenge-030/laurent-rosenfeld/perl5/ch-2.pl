#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

for my $i (1..10) {
    for my $j ($i..10) {
        last if $i + $j > 11;
        for my $k ($j..10) {
            next unless $i * $j * $k % 2 == 0; # Check 1 number is even
            my $sum = $i + $j + $k;
            last if $sum > 12;
            say "$i, $j, $k" if $sum == 12;
        }
    }
}
