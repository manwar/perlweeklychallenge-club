#!/usr/bin/env raku
use Test;

is-deeply missing-members([1,2,3], [2,4,6]),     ([1,3], [4,6]);
is-deeply missing-members([1,2,3,3], [1,1,2,2]), ([3],);

sub missing-members(@a, @b)
{
    # @a (^) @b gives the result in 1 list so I'm doing it like this 🤷

    grep { .Bool }, ((@a (-) @b), (@b (-) @a))>>.keys>>.sort>>.Array
}
