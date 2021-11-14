#!/usr/bin/env raku

use Test;
plan 3;

is two-friendly(8,  24), 1, 'Example 1';
is two-friendly(26, 39), 0, 'Example 2';
is two-friendly(4,  10), 1, 'Example 3';

sub two-friendly($m, $n)
{
    +(log2($m gcd $n).narrow ~~ Int);
}
