#!/usr/bin/env raku

use Test;
plan 9;

my $tests :=
<
    12     3    8        
    18     4    26      
    0      1    1
    1      1    0
    1      2    3
    1      3    5
    255    6    223
    255    7    191
    255    8    127
>;

for $tests
{
    is invert-bit($^a, $^b), $^c
}

sub invert-bit($m where * ~~ ^256, $n where * ~~ 1..8)
{
    $m +^ (1 +< ($n - 1))
}
