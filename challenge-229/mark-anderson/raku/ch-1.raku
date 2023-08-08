#!/usr/bin/env raku
use Test;

is lexicographic-order(<abc bce cae>), 1;
is lexicographic-order(<yxz cba mon>), 2;

sub lexicographic-order(@a)
{
    + @a.map({ $++ if not so any ([le] .comb), ([ge] .comb) })
}
