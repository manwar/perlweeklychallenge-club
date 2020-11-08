#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-085/

my $N = @*ARGS[0] // 8;

for 1..^$N X ^$N -> ($a, $b) {
    say "$N = $a^$b" if $N == $a ** $b;
}
