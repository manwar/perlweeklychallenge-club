#!/usr/bin/env raku
use Test;

is third-highest(5,3,4),   3;
is third-highest(5,6),     6;
is third-highest(5,4,4,3), 3;

multi third-highest(*@a)
{
    third-highest(@a.Set)
}

multi third-highest(Set $s where $s.elems < 3)
{ 
    $s.max.key
}

multi third-highest(Set $s is copy)
{
    $s (-)= $s.max for ^2;
    $s.max.key
}
