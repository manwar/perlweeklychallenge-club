#!/usr/bin/env raku

#
# Perl Weekly Challenge - 072
#
# Task #1: Trailing Zeroes
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-072
#

use Test;

my %test-cases = (
    10 => 2,
     9 => 1,
     8 => 1,
     7 => 1,
     6 => 1,
     5 => 1,
     4 => 0,
     3 => 0,
     2 => 0,
     1 => 0,
);

for %test-cases.keys.sort({ $^a <=> $^b }) -> $N {
    is find-trailing-zeroes($N.Int)[1],
    %test-cases{$N},
    "testing \$N=$N";
}

done-testing;

sub find-trailing-zeroes(Int $N is copy where $N <= 10) {

    # generate factorial
    $N *= $_ for 1..$N-1;

    # match trailing zeroes
    my $trailing-zeroes = $N ~~ m/ <[1..9]>?(<[0]>+)$ /;

    return
    ($trailing-zeroes)
    ??
    ($N, $trailing-zeroes[0].codes)
    !!
    ($N, 0);
}
