#!/usr/bin/env raku
use Test;

is-deeply min-max(3,2,1,4),             (3,2);
is        min-max(3,1),                 -1;
is-deeply min-max(2,1,3),               (2,);

sub min-max(*@a)
{
    my $bounds := @a.minmax.bounds;    
    @a.grep(* ∉ $bounds) || -1
}
