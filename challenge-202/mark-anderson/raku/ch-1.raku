#!/usr/bin/env raku
use Test;

ok  is-consecutive-odds(11, 12, 13, 55, 33, 12, 45, 77, 95, 1, 4);
nok is-consecutive-odds(11, 12, 13, 55, 34, 12, 45, 77, 96, 1, 4);

sub is-consecutive-odds(*@a)
{
    for @a.rotor(3 => -2)
    {
        return 1 if all $_ >>%>> 2 
    }

    return 0
}
