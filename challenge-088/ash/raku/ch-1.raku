#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-088/

my @n = 5, 2, 1, 4, 3;

# Output: 24, 60, 120, 30, 40

my $prod = [*] @n;
my @r = @n.map: $prod / *;

put @r.join(', ');
