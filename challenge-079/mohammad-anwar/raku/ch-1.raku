#!/usr/bin/env raku

#
# Perl Weekly Challenge - 079
#
# Task #1: Count Set Bits
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079
#

use v6.d;

sub MAIN(Int :$N = 4) { count-set-bits($N).say }

#
#
# SUBROUTINE

sub count-set-bits(Int $n) {
    my $c = 0;
    (1..$n).map( -> $i { $c += [+] $i.base(2).comb; });
    return $c % 1000000007;
}
