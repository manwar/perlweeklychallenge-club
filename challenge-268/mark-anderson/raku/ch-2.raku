#!/usr/bin/env raku
use Test;

is-deeply number-game(2,5,3,4),         (3,2,5,4);
is-deeply number-game(9,4,1,3,6,4,6,1), (1,1,4,3,6,4,9,6);
is-deeply number-game(1,2,2,3),         (2,1,3,2);

sub number-game(*@ints)
{
    flat @ints.sort.map({ $^b, $^a })
}
