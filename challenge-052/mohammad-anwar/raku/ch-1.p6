#!/usr/bin/env perl6

use v6.c;

sub MAIN(Int $start is copy = 100, Int $stop = 999) {

    die "ERROR: Invalid start [$start]." if $start < 100;
    die "ERROR: Invalid stop [$stop]."   if $stop  > 999 || $stop < $start;

    while $start <= $stop {
        say $start if ([==] $start.comb("") Z- <0 1 2>)
                      ||
                      ([==] $start.comb("") Z- <2 1 0>);
        $start++;
    }
}
