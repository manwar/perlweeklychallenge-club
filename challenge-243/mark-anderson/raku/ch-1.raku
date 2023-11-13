#!/usr/bin/env raku
use Test;
use experimental :cached;

is reverse-pairs(1,3,2,3,1), 2;
is reverse-pairs(2,4,3,5,1), 3;

sub reverse-pairs(*@a)
{
    sub rp($p) is cached
    {
        .[0] > .[1] * 2 given |$p
    }
    
    + @a.combinations(2).grep(&rp)
}
