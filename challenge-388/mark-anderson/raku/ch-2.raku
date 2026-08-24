#!/usr/bin/env raku
use Test;

is secret-santa(1),    0;
is secret-santa(2),    1;
is secret-santa(3),    2;
is secret-santa(4),    9;
is secret-santa(5),    44;

is secret-santa-v2(1), 0;
is secret-santa-v2(2), 1;
is secret-santa-v2(3), 2;
is secret-santa-v2(4), 9;
is secret-santa-v2(5), 44;

sub secret-santa($n) { round ([*] 2..$n) / e }

sub secret-santa-v2($n)
{
    use Math::Combinatorics <derangements>;
    (derangements 1..$n).elems
}
