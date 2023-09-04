#!/usr/bin/env raku
use Test;

is similar-words(<aba aabb abcd bac aabc>), 2;
is similar-words(<aabb ab ba>),             3;
is similar-words(<nba cba dba>),            0;

sub similar-words(*@a)
{
    @a.combinations(2).grep({ [eqv] .map({ .comb.Set }) }).elems 
}
