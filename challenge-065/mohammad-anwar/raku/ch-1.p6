#!/usr/bin/env perl6

#
# Perl Weekly Challenge - 065
#
# Task #1: Digits Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-065/
#

use v6.d;

sub MAIN(Int :$N? where { $N > 1 } = 2, Int :$S? where { $S > 0 } = 4) {

    find-numbers($N, $S).join(", ").say;
}

sub find-numbers(Int $N, Int $S) {

    my $start = ('1' ~ '0' x ($N - 1)).Int;
    my $end   = ('9' x $N).Int;

    return ($start .. $end).grep( -> $n { $S == $n.split('').sum });
}
