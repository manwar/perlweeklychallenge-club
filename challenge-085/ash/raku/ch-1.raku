#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-085/

my @r = 1.2, 0.4, 0.1, 2.5;
say +so 1 < any(@r.combinations(3)>>.sum) < 2;
