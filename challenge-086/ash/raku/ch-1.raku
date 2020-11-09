#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-086/

my @n = 10, 8, 12, 15, 5;
my $a = 7;

say +so $a == any(@n.combinations(2).map: { abs(.[0] - .[1]) });
