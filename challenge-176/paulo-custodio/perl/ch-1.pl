#!/usr/bin/env perl

# Challenge 176
#
# Task 1: Permuted Multiples
# Submitted by: Mohammad S Anwar
#
# Write a script to find the smallest positive integer x such that x, 2x, 3x,
# 4x, 5x and 6x are permuted multiples of each other.
#
# For example, the integers 125874 and 251748 are permutated multiples of each
# other as
#
# 251784 = 2 x 125874
#
# and also both have the same digits but in different order.
#
# Output
#
# 142857

use Modern::Perl;

sub is_permuted {
    my($a, $b) = @_;
    return join('', sort split //, $a) eq join('', sort split //, $b);
}

sub is_permuted_multiple {
    my($n, $k) = @_;
    return is_permuted($n, $n*$k);
}

sub is_permuted_multiples {
    my($n) = @_;
    return is_permuted_multiple($n, 2) &&
           is_permuted_multiple($n, 3) &&
           is_permuted_multiple($n, 4) &&
           is_permuted_multiple($n, 5) &&
           is_permuted_multiple($n, 6);
}

sub smallest_permuted_multiples {
    my $n = 1;
    while (1) {
        return $n if is_permuted_multiples($n);
        $n++;
    }
}

say smallest_permuted_multiples();
