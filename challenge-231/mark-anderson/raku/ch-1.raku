#!/usr/bin/env raku
use Test;

is-deeply min-max(3,2,1,4),             (3,2);
is        min-max(3,1),                 -1;
is-deeply min-max(2,1,3),               (2,);
is-deeply min-max(5,2,4,2,1,1,1,7,7,2), (5,2,4,2,2);
say min-max((1..99).roll(1e6)).tail(25);

sub min-max(+@a)
{
    my $bounds := @a.minmax.bounds;    
    @a.grep(* ∉ $bounds) || -1
}
