#!/usr/bin/env raku

#
# Perl Weekly Challenge - 075
#
# Task #1: Coins Sum
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-075
#

use v6.d;

sub MAIN(Str :$COINS = "1, 2, 4", Int :$SUM = 6) {
    say "Possible ways to achieve the target: " ~
        coins-sum($COINS, $SUM);
}

sub coins-sum(Str $coins is copy, Int $sum) returns Int {

    die "ERROR: Invalid coins [$coins].\n"
        unless $coins ~~ /^[\s?\-?\d\,?\s?]+$/;

    say "Coins: $coins";
    $coins ~~ s:g/\s//;
    my $_coins = [ $coins.split(',').map({ .Int }) ];

    my $size = $_coins.elems;
    return 0 if ($size == 0 || $sum <= 0);

    my $matrix;

    # Sum of 0 can be achieved in one possible way.
    $matrix.[$_][0] = 1 for (0 .. $size-1);

    for 0 .. $size-1 -> $i {

        for 1 .. $sum -> $j {

            my Int $include-current = 0;
            my Int $exclude-current = 0;

            if $_coins.[$i] <= $j {
                $include-current = $matrix.[$i][$j - $_coins.[$i]];
            }

            if $i > 0 {
                $exclude-current = $matrix.[$i - 1][$j];
            }

            $matrix.[$i][$j] = $include-current + $exclude-current;
        }
    }

    return $matrix.[$size-1][$sum];
}
