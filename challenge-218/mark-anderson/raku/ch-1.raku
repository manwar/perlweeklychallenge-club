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

multi max-product(+$a where .elems == 3)
{
    [*] |$a
}

multi max-product(+$a)
{
    my %c = $a.classify({ .sign });    

    return [*] $a.sort.tail(3) if $a == any %c.values; 

    my @neg = %c{-1}.sort.head(2);
    my @pos = %c{1}.sort.tail(3);

    max gather 
    {
        take 0;
        take [*] @pos if @pos == 3;
        take [*] |@neg, @pos.max if @neg == 2
    }
}
