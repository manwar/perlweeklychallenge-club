#!/usr/bin/env raku
use Test;

is counter-ints("the1weekly2challenge2"), (1,2);
is counter-ints("go21od1lu5c7k"),         (21,1,5,7);
is counter-ints("4p3e2r1l"),              (4,3,2,1);

sub counter-ints($str)
{
    $str.comb(/\d+/).unique
}
