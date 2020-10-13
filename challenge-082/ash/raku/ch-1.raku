#!/usr/bin/env raku
#
# Task 1 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-082/

# Test runs:
# $ raku ch-1.raku 12 18
# (1 2 3 6)
# $ raku ch-1.raku 100 500
# (1 2 4 5 10 20 25 50 100)
# $ raku ch-1.raku 18 23
# (1)

my ($a, $b) = @*ARGS;

say ((1 .. ($a max $b)).grep: $a %% *).grep: $b %% *;
