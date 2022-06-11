#!/usr/bin/env perl

# Challenge 156
#
# TASK #2 › Weird Number
# Submitted by: Mohammad S Anwar
# You are given number, $n > 0.
#
# Write a script to find out if the given number is a Weird Number.
#
# According to Wikipedia, it is defined as:
#
# The sum of the proper divisors (divisors including 1 but not itself) of the
# number is greater than the number, but no subset of those divisors sums to
# the number itself.
#
# Example 1:
# Input: $n = 12
# Output: 0
#
# Since the proper divisors of 12 are 1, 2, 3, 4, and 6, which sum to 16; but
# 2 + 4 + 6 = 12.
# Example 2:
# Input: $n = 70
# Output: 1
#
# As the proper divisors of 70 are 1, 2, 5, 7, 10, 14, and 35; these sum to
# 74, but no subset of these sums to 70.

use Modern::Perl;
use Math::Combinatorics 'combine';
use List::Util 'sum';
use ntheory 'divisors';

my $n = shift || 0;
say is_weird($n);

sub proper_divisors {
    my($n) = @_;
    return grep {$_!=$n} divisors($n);
}

sub check_no_subset_sums_n {
    my($n, @div) = @_;
    for my $k (1 .. scalar(@div)) {
        for my $combin (combine($k, @div)) {
            return 0 if sum(@$combin) == $n;
        }
    }
    return 1;
}

sub is_weird {
    my($n) = @_;
    my @div = proper_divisors($n);
    return 0 if sum(@div) <= $n;
    return check_no_subset_sums_n($n, @div);
}
