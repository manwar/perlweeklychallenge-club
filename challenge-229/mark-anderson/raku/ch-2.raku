#!/usr/bin/env raku
use Test;

is-deeply two-out-of-three([1,1,2,4], [2,4], [4]),               set (2,4);
is-deeply two-out-of-three([4,1], [2,4], [1,2]),                 set (1,2,4);
is-deeply two-out-of-three([1,1,2,4], [2,4], [1,1,1,4]),         set (1,2,4);
is-deeply two-out-of-three([1,1,2,4], [2,2,4], [1,1,1,2,2,2,4]), set (1,2,4);


is-deeply two-out-of-three-with-repeats([1,1,2,4], [2,4], [4]),               (2,4);
is-deeply two-out-of-three-with-repeats([4,1], [2,4], [1,2]),                 (1,2,4);
is-deeply two-out-of-three-with-repeats([1,1,2,4], [2,4], [1,1,1,4]),         (1,1,2,4);
is-deeply two-out-of-three-with-repeats([1,1,2,4], [2,2,4], [1,1,1,2,2,2,4]), (1,1,2,2,4);

sub two-out-of-three(@a, @b, @c)
{
    @a ∩ @b ∪ @a ∩ @c ∪ @b ∩ @c
}

sub two-out-of-three-with-repeats(@a, @b, @c)
{
    sort .kxxv given @a.Bag ∩ @b.Bag ∪ @a.Bag ∩ @c.Bag ∪ @b.Bag ∩ @c.Bag
}
