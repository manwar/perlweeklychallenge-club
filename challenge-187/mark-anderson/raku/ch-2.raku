#!/usr/bin/env raku
use Test;

is-deeply max-magical-triplet(1, 2, 3, 2), (3, 2, 2);
is-deeply max-magical-triplet(1, 3, 2),    ();
is-deeply max-magical-triplet(1, 1, 2, 3), ();
is-deeply max-magical-triplet(2, 4, 3),    (4, 3, 2);

sub max-magical-triplet(+$list)
{
    $list.sort(-*)
         .rotor(3 => -2)
         .first({ .[0] < .[1] + .[2] }) // Empty.List
}
