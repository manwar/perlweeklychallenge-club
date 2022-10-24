#!/usr/bin/env raku
use Test;

is total-zero(5, 4),        5;
is total-zero(4, 6),        3;
is total-zero(2, 5),        4;
is total-zero(3, 1),        3;
is total-zero(7, 4),        5;
is total-zero(5, 13),       6;
is total-zero(3, 5),        4;
is total-zero(100, 19),    13;
is total-zero(100, 20),     5;
is total-zero(10000, 19), 535;

sub total-zero($x, $y)
{
    my $steps;

    sink $x, $y, { $steps++ if $^x > $^y; abs($^x - $^y) } ... 0;
 
    $steps + 1
}
