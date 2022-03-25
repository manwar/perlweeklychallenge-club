#!/usr/bin/env perl

# Challenge 156
#
# TASK #1 > Pernicious Numbers
# Submitted by: Mohammad S Anwar
# Write a script to permute first 10 Pernicious Numbers.
#
# A pernicious number is a positive integer which has prime number of ones in
# its binary representation.
#
# The first pernicious number is 3 since binary representation of 3 = (11)
# and 1 + 1 = 2, which is a prime.
#
# Expected Output
# 3, 5, 6, 7, 9, 10, 11, 12, 13, 14

use Modern::Perl;
use ntheory 'is_prime';

say join(", ", first_pernicious(10));

sub is_pernicious {
    my($n) = @_;
    my $bin = sprintf("%b", $n);
    my $ones = $bin =~ tr/1/1/;
    my $is_pernicious = is_prime($ones);
    return $is_pernicious;
}

sub first_pernicious {
    my($num) = @_;
    my @out;

    my $n = 0;
    while (@out < $num) {
        if (is_pernicious($n)) {
            push @out, $n;
        }
        $n++;
    }
    return @out;
}
