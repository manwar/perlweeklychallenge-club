#!/usr/bin/perl6

(100 .. 999).grep({
    my @digits = $_.comb;
    abs(@digits[0] - @digits[1]) == 1 && abs(@digits[1] - @digits[2]) == 1;
}).join(q{ }).say;

