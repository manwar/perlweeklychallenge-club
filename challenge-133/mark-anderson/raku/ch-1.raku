#!/usr/bin/env raku

use Test;
plan 4;

is isqrt(10),   3;
is isqrt(27),   5;
is isqrt(85),   9;
is isqrt(101), 10;

# from https://stackoverflow.com/a/15391420

sub isqrt($n)
{
    my $x = $n;
    my $y = ($x + 1) div 2;

    while $y < $x
    {
        $x = $y;
        $y = ($x + $n div $x) div 2;
    }

    $x;
}
