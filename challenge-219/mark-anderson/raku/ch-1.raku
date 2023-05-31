#!/usr/bin/env raku
use Test;

is-deeply sorted-squares(-2,-1,0,3,4), (0,1,4,9,16);
is-deeply sorted-squares(5,-4,-1,3,6), (1,9,16,25,36);

sub sorted-squares(+$a)
{
    sort $a >>**>> 2
}
