#!/usr/bin/env raku
use Test;

is binary-flip(5), 2;
is binary-flip(4), 3;
is binary-flip(6), 1;

sub binary-flip($n)
{
    (1 x $n.base(2).chars).parse-base(2) +^ $n;
}
