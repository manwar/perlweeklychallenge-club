#!/usr/bin/env raku
use Test;
plan 4;

is pattern-match("abcde", "a*e"),   1;
is pattern-match("abcde", "a*d"),   0;
is pattern-match("abcde", "?b*d"),  0;
is pattern-match("abcde", "a*c?e"), 1;

sub pattern-match($S, $P) 
{
    ($S ~~ / ^ <{ $P.trans: <? *> => <. .*> }> $ /).Bool.UInt;
}
