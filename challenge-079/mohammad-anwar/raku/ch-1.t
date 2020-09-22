#!/usr/bin/env raku

#
# Perl Weekly Challenge - 079
#
# Task #1: Count Set Bits
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-079
#

use Test;

is count-set-bits(4), 5, "testing example 1";
is count-set-bits(3), 4, "testing example 2";

done-testing;

#
#
# SUBROUTINE

sub count-set-bits(Int $n) {
    my $c = 0;
    (1..$n).map( -> $i { $c += [+] $i.base(2).comb; });
    return $c % 1000000007;
}
