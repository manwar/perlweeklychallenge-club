#!/usr/bin/env raku
use Test;

is zero-array([1,5,0,3,5]), 3;
is zero-array([0]),         0;
is zero-array([2,1,4,0,3]), 4;

sub zero-array(@a, $c=0)
{
    @a .= grep(*.so);
    return $c unless @a;
    zero-array(@a >>->> @a.min, $c.succ)
}
