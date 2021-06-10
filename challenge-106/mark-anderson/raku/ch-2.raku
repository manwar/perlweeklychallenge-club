#!/usr/bin/env raku

use Test;
plan 4;

is decimal-string(1, 3),      "0.(3)";
is decimal-string(1, 2),      "0.5";
is decimal-string(5, 66),     "0.0(75)";
is decimal-string(3227, 555), "5.8(144)";

sub decimal-string($n, $d)
{
    my ($non-rep, $rep) = ($n/$d).base-repeating;

    return $non-rep unless $rep;

    return sprintf '%s(%s)', $non-rep, $rep;
}
