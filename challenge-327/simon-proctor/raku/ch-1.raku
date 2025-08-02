#!/usr/bin/env raku

#|(Given a list of integers find all the
values not in the list from 1..n where
n is the length of the list)
sub MAIN(
    *@a where @a.all ~~ UInt #= A list of unsigned integers
) {
    my @list = @a.map( *.Int );
    ((1..@list.elems) ∖ @list).keys.sort.say;
}
