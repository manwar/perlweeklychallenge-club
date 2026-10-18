#!/usr/bin/env raku
use Test;

is complex-number( 1+1i,     1+1i),       0+2i;
is complex-number( 1+(-1)i,  1+(-1)i),    0+(-2)i;
is complex-number( 0+3i,     0+4i),     -12+0i;
is complex-number( 3+4i,     3+(-4)i),   25+0i;
is complex-number(50+-20i, -10+30i),    100+1700i;

sub complex-number($num1, $num2) { $num1 * $num2 }
