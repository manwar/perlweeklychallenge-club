#!/usr/bin/env raku
use Test;

ok  remove-one(0,2,9,4,6);
nok remove-one(5,1,3,2);
ok  remove-one(2,2,3);
nok remove-one(0,2,4,8,3,6);
ok  remove-one(1,2,3,4,5);

sub remove-one(*@a)  
{
    for @a.unshift(-∞).rotor(3 => -2)
    {
        next         if .[1] < .[2];
        return False if .[0] > .[2];
        return False if $++
    }

    True
}
