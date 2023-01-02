#!/usr/bin/env raku
use Test;

is max-gap(2,5,8,1),                          2;
is max-gap(3),                                0;
is max-gap(1..9),                             8;
is max-gap(1,6,5,2,7,9,14,15,20,24,29,30,25), 5;

sub max-gap(+$list) 
{ 
    $list.rotor(2 => -1).map({ .tail - .head }).maxpairs.elems 
}    
