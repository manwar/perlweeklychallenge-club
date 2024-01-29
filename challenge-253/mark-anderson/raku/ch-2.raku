#!/usr/bin/env raku
use Test;

is-deeply weakest-rows([ <1 1 0 0 0>,
                         <1 1 1 1 0>,
                         <1 0 0 0 0>,
                         <1 1 0 0 0>,
                         <1 1 1 1 1> ]), (2,0,3,1,4);

is-deeply weakest-rows([ <1 0 0 0>,
                         <1 1 1 1>,
                         <1 0 0 0>,
                         <1 0 0 0> ]), (0,2,3,1);

is-deeply weakest-rows([ <1 1 0 0 0>,
                         <0 0 0 0 0>,
                         <1 1 1 1 0>,
                         <0 0 0 0 0>,
                         <1 1 1 1 1>,
                         <0 0 0 0 0>,
                         <1 1 0 0 0>,
                         <1 1 1 1 1>,
                         <1 1 1 1 1>,
                         <1 0 0 0 0> ]), (1,3,5,9,0,6,2,4,7,8);

sub weakest-rows($m)
{
    $m.sort(:k) # requires 2023.08 or later
}
