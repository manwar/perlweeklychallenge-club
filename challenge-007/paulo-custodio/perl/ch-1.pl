#!/usr/bin/perl

# Challenge 007
#
# Challenge #1
# Print all the niven numbers from 0 to 50 inclusive, each on their own line.
# A niven number is a non-negative number that is divisible by the sum of its digits.

use strict;
use warnings;
use 5.030;

sub solve {
    my($max) = @_;
    for my $n (1..$max) {
        my $sum = sum(split //, $n);
        say $n if $n % $sum == 0;
    }
}

sub sum {
    my($sum, @a) = @_;
    $sum += $_ for @a;
    return $sum;
}


my $max = shift || 50;
solve($max);
