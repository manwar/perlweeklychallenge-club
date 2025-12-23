#!/usr/bin/env raku
use Test;

is-deeply binary-prefix(0,1,1,0,0,1,0,1,1,1), (True, False, False, False, False, True, True, False, False, False);
is-deeply binary-prefix(1,0,1,0,1,0),         (False, False, True, True, False, False);
is-deeply binary-prefix(0,0,1,0,1),           (True, True, False, False, True);
is-deeply binary-prefix(1,1,1,1,1),           (False, False, False, True, False);
is-deeply binary-prefix(1,0,1,1,0,1,0,0,1,1), (False, False, True, False, False, True, True, True, False, False);

sub binary-prefix(*@n)
{
    ([\~] @n).map(*.Str.parse-base(2) %% 5)
}
