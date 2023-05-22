#!/usr/bin/env raku
use Test;

is max-product(3,1,2),            6;
is max-product(4,1,3,2),         24;
is max-product(-1,0,1,3,1),       3;
is max-product(-8,2,-9,0,-4,3), 216;
is max-product(-8,-9,0,0,0,1),   72;
is max-product(1,-2,3,4,5),      60;      
is max-product(1,-2,3),          -6;
is max-product(4,0,-3,5),         0;
is max-product(-3,-2,0,-4),       0;
is max-product(-3,-2,1,-4),      12;
is max-product(-3,-5,-2,-4),    -24;
is max-product(-1,-1,1,1),        1;
is max-product(-1,-1,-1,0),       0;
is max-product(-1,-1,-1,1),       1;
is max-product(1,1,1,0),          1;
is max-product(0,0,0,0),          0;
is max-product(1,2,0,-1),         0;
is max-product(-1,0,0,-1),        0;

sub max-product(+$a)
{
    given $a.sort.Array 
    {
        max ([*] .tail(3)), ([*] flat .head(2), .tail)
    }
}
