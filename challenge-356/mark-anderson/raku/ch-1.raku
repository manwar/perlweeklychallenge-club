#!/usr/bin/env raku
use Test;
plan 5;

is kolakoski(4), 2;
is kolakoski(5), 3;
is kolakoski(6), 3;
is kolakoski(7), 4;
is kolakoski(8), 4;

sub kolakoski($i)
{
    my $str = 122;
    my $c   = 2;

    until $str.chars >= $i
    {
        $str ~= 1 x $str.substr($c++, 1);
        $str ~= 2 x $str.substr($c++, 1);
    }

    $str.substr(0, $i).comb('1').elems
}
