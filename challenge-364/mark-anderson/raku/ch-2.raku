#!/usr/bin/env raku
use Test;

is goal-parser("G()(al)"),       "Goal";
is goal-parser("G()()()()(al)"), "Gooooal";
is goal-parser("(al)G(al)()()"), "alGaloo";
is goal-parser("()G()G"),        "oGoG";
is goal-parser("(al)(al)G()()"), "alalGoo";

sub goal-parser($str)
{
    $str.trans(<() (al)> => <o al>)
}
