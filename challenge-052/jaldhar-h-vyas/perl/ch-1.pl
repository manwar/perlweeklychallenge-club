#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

say join q{ }, grep {
    my @digits = split //;

    abs($digits[0] - $digits[1]) == 1 && abs($digits[1] - $digits[2]) == 1;
} 100 .. 999;

