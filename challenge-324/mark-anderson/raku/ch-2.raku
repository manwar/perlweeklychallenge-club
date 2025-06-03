#!/usr/bin/env raku
use Test;

is total-xor(1,3),   6;
is total-xor(5,1,6), 28;
is total-xor(3..8),  480;

sub total-xor(+@ints)
{
    [+] @ints.combinations.race.map({ [+^] $_ })
}
