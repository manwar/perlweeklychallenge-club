#!/usr/bin/env raku

use Test;
plan 9;

my @tests = < 
              101  154
              18   33
              255  255
              1    2
              170  85
              85   170
              204  204
              9    6
              10   5   
            >;
            
for @tests -> $a, $b
{
    is swap-odd-even-bits($a), $b
}

sub swap-odd-even-bits($N where $N ~~ 1..255)
{
    $N.fmt('%08b').comb[ 1,0,3,2,5,4,7,6 ].join.parse-base(2)
}
