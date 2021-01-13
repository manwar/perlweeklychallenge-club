#!/usr/bin/env perl6

#
# Perl Weekly Challenge - 065
#
# Task #1: Digits Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-065/
#

use Test;

is find-numbers(2, 4),  (13, 22, 31, 40), 'N=2, S=4';
is find-numbers(3, 26), (899, 989, 998),  'N=3, S=26';
is find-numbers(3, 30), (),               'N=3, S=30';

done-testing;

sub find-numbers(Int $N, Int $S) {

    my $start = ('1' ~ '0' x ($N - 1)).Int;
    my $end   = ('9' x $N).Int;

    return ($start .. $end).grep( -> $n { $S == $n.split('').sum });
}
