#!/usr/bin/env raku
use Test;

is my-parse-base("101010", 2),  42;
is my-parse-base("EEADEE", 16), 15642094;
is my-parse-base("755", 8),     493;
is my-parse-base("1BRJB", 36),  2228519;
is my-parse-base("7MyqL", 64),  123456789;

sub my-parse-base($num, $base)
{
    my %n is Map = (flat '0'..'9', 'A'..'Z', 'a'..'z', '+', '/').antipairs;
    sum %n{$num.comb} >>*<< ($base xx $num.chars) >>**<< ($num.chars^...0)
}
