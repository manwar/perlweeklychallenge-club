#!/usr/bin/env raku
use Test;

is-deeply duplicate-zeros(1,0,2,3,0,4,5,0), (1,0,0,2,3,0,0,4);
is-deeply duplicate-zeros(1,2,3),           (1,2,3);
is-deeply duplicate-zeros(0,3,0,4,5),       (0,0,3,0,0);

sub duplicate-zeros(*@a is copy)
{
    my @k = @a.grep(not *, :k);

    @a[@k] = (0,0) xx @k;

    @a.List.flat.head(@a)
}
