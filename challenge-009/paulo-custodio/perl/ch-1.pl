#!/usr/bin/perl

# Challenge 009
#
# Challenge #1
# Write a script that finds the first square number that has at least 5 distinct
# digits. This was proposed by Laurent Rosenfeld.

use strict;
use warnings;
use 5.030;

sub num_diff_digits {
    my($n) = @_;
    my %digits;
    while ($n > 0) {
        my $digit = $n % 10;
        $digits{$digit}++;
        $n = int($n/10);
    }
    return scalar(keys %digits);
}

my $diff_digits = shift || 5;
my $n = 1;
$n++ while (num_diff_digits($n*$n) < $diff_digits);
say $n*$n;
