#!/usr/bin/env raku
use Test;

is-deeply smaller-than-current(5,2,1,6), (2,1,0,3);
is-deeply smaller-than-current(1,2,0,3), (1,2,0,3);
is-deeply smaller-than-current(0,1),     (0,1);
is-deeply smaller-than-current(9,4,9,2), (2,1,2,0);

sub smaller-than-current(*@a)
{
    @a.sort.squish.antipairs.Map{@a}
}
