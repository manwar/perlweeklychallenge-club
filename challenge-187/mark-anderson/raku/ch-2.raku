#!/usr/bin/env raku
use Test;

is-deeply max-magical-triplet(1, 2, 3, 2), (3, 2, 2);
is-deeply max-magical-triplet(1, 3, 2),    ();
is-deeply max-magical-triplet(1, 1, 2, 3), ();
is-deeply max-magical-triplet(2, 4, 3),    (4, 3, 2);

sub max-magical-triplet(+$list)
{
    $list.combinations(3)
         .map({ |.permutations })
         .unique(with => &[eqv])
         .flat
         .grep({ [and] $^a + $^b > $^c,
                       $^b + $^c > $^a, 
                       $^a + $^c > $^b })
         andthen
         .elems ?? .max !! Empty.List
}
