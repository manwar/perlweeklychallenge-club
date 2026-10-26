#!/usr/bin/env raku
use Test;

is-deeply br(3,6,12),      (3,6,12);
is-deeply br(1,2,4,8),     (1,2,4,8);
is-deeply br(7,8,9,10),    (8,10,7,9);
is-deeply br(5,9,15,17),   (5,9,15,17);
is-deeply br(11,13,14,19), (14,13,11,19);

sub br(*@arr)
{
    @arr.sort: { .base(2).flip.parse-base(2), $_ } 
}
