#!/usr/bin/env raku

use Test;
plan 2;

is   jortsort(1, 2, 3, 4, 5), 1;
isnt jortsort(1, 3, 2, 4, 5), 1;

sub jortsort(+@a)
{
    + [<=] @a;
}
