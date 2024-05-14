#!/usr/bin/env raku
use Test;

ok  bitwise-or(1,2,3,4,5);
ok  bitwise-or(2,3,8,16);
nok bitwise-or(1,2,5,7,9);

sub bitwise-or(*@ints)
{
    @ints ~~ m:2nd/ << (<.digit>+) >> <?{ $0 %% 2 }> /
}
