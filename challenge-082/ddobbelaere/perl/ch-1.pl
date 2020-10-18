#!/usr/bin/perl

=begin
https://perlweeklychallenge.org/blog/perl-weekly-challenge-082/

TASK #1 › Common Factors
Submitted by: Niels van Dijke

You are given 2 positive numbers $M and $N.

Write a script to list all common factors of the given numbers.

Example 1:

Input:
    $M = 12
    $N = 18

Output:
    (1, 2, 3, 6)

Explanation:
    Factors of 12: 1, 2, 3, 4, 6
    Factors of 18: 1, 2, 3, 6, 9

Example 2:

Input:
    $M = 18
    $N = 23

Output:
    (1)

Explanation:
    Factors of 18: 1, 2, 3, 6, 9
    Factors of 23: 1
=cut

use v5.30;
use warnings;
use experimental 'smartmatch';

sub common_factors {
    my ($M, $N) = @_;
    grep {!($N%$_ || $M%$_)} (1..$M);
}

# Tests.
while (<DATA>) {
    next if /^#/;
    /\(([^\)]*)\) \(([^\)]*)\)/;
    my ($M, $N) = split /,/, $1;
    my @expected = split /,/, $2;

    my @actual = common_factors($M, $N);
    @expected ~~ @actual || die "Error for (M,N)=($M,$N). Expected @expected, got @actual.";
}

# Console interface.
if (@ARGV) {
    say join ', ', common_factors(@ARGV);
}

__DATA__
# Test data.
(12, 18) (1, 2, 3, 6)
(18, 12) (1, 2, 3, 6)
(18, 23) (1)
(23, 18) (1)