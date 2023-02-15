#!/usr/bin/env raku
use Test;

ok  monotonic-array(1,2,2,3);
nok monotonic-array(1,3,2);
ok  monotonic-array(6,5,5,4);
 
sub monotonic-array(*@a)
{
    return 1 if [<=] @a;
    return 1 if [>=] @a;
    return 0
}
