#!/usr/bin/env raku
use Test;

is kaprekar(3524),  3;
is kaprekar(6174),  0;
is kaprekar(9998),  5;
is kaprekar(1001),  4;
is kaprekar(9000),  4;
is kaprekar(1111), -1;

multi kaprekar(UInt $i where [==] $i.comb)     { -1                     }
multi kaprekar(UInt $i where $i ~~ 1000..9999) { ($i, &k...^6174).elems }

sub k($i is copy)
{
    $i = $i.comb.sort.join;
    ($i.flip - $i).fmt('%04d')
}
