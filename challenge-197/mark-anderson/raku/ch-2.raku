#!/usr/bin/env raku
use Test;

is-deeply wiggle-sort(1,5,1,1,6,4),     (1,6,1,5,1,4);
is-deeply wiggle-sort(1,3,2,2,3,1),     (2,3,1,3,1,2);
is-deeply wiggle-sort(1,1,1,2,2,2),     (1,2,1,2,1,2);
is-deeply wiggle-sort(1,2,3,4,5,6,7),   (4,7,3,6,2,5,1);
is-deeply wiggle-sort(1,2,3,4,5,6,7,8), (4,8,3,7,2,6,1,5);

sub wiggle-sort(*@a)
{
    @a .= sort: -*;
    my $d = @a / 2;
    flat roundrobin @a.tail($d.ceiling), @a.head($d.floor)
}
