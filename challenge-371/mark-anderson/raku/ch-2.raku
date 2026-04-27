#!/usr/bin/env raku
use Test;

is-deeply subset-equilibrium([2,1,4,3]),     ([2,1], [2,3], [1,4], [4,3]);
is-deeply subset-equilibrium([3,0,3,0]),     ([3,0], [3,0,3]);
is-deeply subset-equilibrium([5,1,1,1]),     ([5,1,1],);
is-deeply subset-equilibrium([3,-1,4,2]),    ([3,2], [3,-1,4]);
is-deeply subset-equilibrium([10,20,30,40]), Empty.Seq; 

sub subset-equilibrium(@nums)
{
    gather for @nums.pairs.combinations(2..@nums.end) -> @p
    {
        my @v = @p>>.value;
        my @k = @p>>.key;
        take @v if @v.sum == @k.sum + @k.elems
    }
}
