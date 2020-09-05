#!/usr/bin/env raku

#
# Perl Weekly Challenge - 076
#
# Task #1: Prime Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-076
#

use v6.d;

sub MAIN(Int $SUM where $SUM > 0) {
    prime-sum($SUM).join("\n").say;
}

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
