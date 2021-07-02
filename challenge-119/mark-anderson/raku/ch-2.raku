#!/usr/bin/env raku

#
# added base(4) after looking at other solutions.
#

use Test;
plan 3;

is seq(5),    13;
is seq(10),   32;
is seq(60), 2223;
is seq(1000), 1332223;

sub seq($N where * > 0)
{
    (1..*).map(*.base(4)).grep(* !~~ /0||11/)[$N-1]
}
