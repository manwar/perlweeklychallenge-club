#!/usr/bin/env raku
use Test;

is-deeply missing-numbers(0,1,3), (2,);
is-deeply missing-numbers(0,1),   (2,);
is-deeply missing-numbers(2,3,8), (0,1,4,5,6,7);

sub missing-numbers(*@a)
{
    my $n = max((max @a), @a.elems);
    ((0..$n) (-) @a).keys.sort
}
