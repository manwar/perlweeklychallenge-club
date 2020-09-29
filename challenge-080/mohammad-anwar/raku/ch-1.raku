#!/usr/bin/env raku

#
# Perl Weekly Challenge - 080
#
# Task #1: Smallest Positive Number
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-080
#

use v6.d;

sub MAIN(:@N where .all ~~ Int = (2, 3, 7, 6, 8, -1, -10, 15)) {
    say smallest-positive-number(@N);
}

sub smallest-positive-number(@n where .all ~~ Int) {

    my @positive-numbers = @n.sort.grep: { $_ > 0 };
    return 1 unless @positive-numbers.elems;

    my $i = 0;
    (1 .. @positive-numbers.tail).map: -> $n {
        return $n if $n < @positive-numbers[$i++]
    };

    return ++@positive-numbers.tail;
}
