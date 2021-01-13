#!/usr/bin/env perl6

#
# Perl Weekly Challenge - 066
#
# Task #2: Power Integers
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-066/
#

use v6.d;

sub MAIN(Int :$N where $N > 1 = 9) {
    say sprintf("%d = %s", $N, get-power-integers($N).join(", "));
}

sub get-power-integers(Int $n where { $n > 1 }) {

    my $power_integers = [];

    my $i = 2;
    while $i <= sqrt($n) {
        my $j = 2;
        while $j <= $n {
            if ($i ** $j) == $n {
                $power_integers.push: sprintf("%d ^ %d", $i, $j);
            }
            $j++;
        }
        $i++;
    }

    return $power_integers if $power_integers.elems > 0;
    return 0;
}
