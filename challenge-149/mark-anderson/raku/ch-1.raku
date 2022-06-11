#!/usr/bin/env raku

use Test;

is-deeply fibonacci-digit-sum(20),
(0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44);

is fibonacci-digit-sum(10000).tail, 98809;

sub fibonacci-digit-sum(\n)
{
    my @fib = 0, 1, * + * ... 55; # good enough for numbers <= 9,999,991

    (^Inf).grep({ .comb.sum (elem) @fib })[^n];
}
