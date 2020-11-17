#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-087/

# See also ch-1a.raku for a more straighforward and more efficient solution.

my @n = 100, 51, 52, 4, 5, 50, 3, 2;

put @n.sort.combinations(2..*).grep({.[*-1] - .[0] == .elems - 1}).sort(*.elems).tail // 0
