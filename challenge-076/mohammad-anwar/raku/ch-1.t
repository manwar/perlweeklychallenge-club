#!/usr/bin/env raku

#
# Perl Weekly Challenge - 076
#
# Task #1: Prime Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-076
#

use Test;

is-deeply prime-sum(6).<>,  [],                  "prime sum = 6";
is-deeply prime-sum(9).<>,  [(2, 7),],           "prime sum = 9";
is-deeply prime-sum(12).<>, [(5, 7), (2, 3, 7)], "prime sum = 12";

done-testing;

#
#
# METHODS

sub prime-sum(Int $sum) {

    my @prime = find-prime-upto($sum);
    my @prime-sum = Empty;
    for 1..$sum -> $i {
        for @prime.combinations: $i -> $j {
            my $_sum = [+] $j;
            @prime-sum.push: $j if $_sum == $sum;
        }
    }

    return @prime-sum;
}

sub find-prime-upto(Int $sum) {
    return (2..$sum).grep: { .is-prime };
}
