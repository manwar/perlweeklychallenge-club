#!/usr/bin/env raku
use Test;

is array-pairings(< 1 2 3 4 >),     4;
is array-pairings(< 0 2 1 3 >),     2;
is array-pairings(< 1 2 3 4 5 6 >), 5;

sub array-pairings(@a where * %% 2)
{
    my @c = @a.combinations(@a.elems div 2);

    max map 
    {
        sum .map({ .min })
    }, 
    (@c[^(@c.elems div 2)] Z @c[@c.elems div 2..@c.end].reverse)
}
