#!/usr/bin/env raku
use Test;

is-deeply magical-triplets(1, 2, 3, 2), (3, 2, 2);
is-deeply magical-triplets(1, 3, 2),    ();
is-deeply magical-triplets(1, 1, 2, 3), ();
is-deeply magical-triplets(2, 4, 3),    (4, 3, 2);

sub magical-triplets(+$list)
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
