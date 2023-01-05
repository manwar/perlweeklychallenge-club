#!/usr/bin/env raku
use Test;

is max-gap(2,5,8,1),      2;
is max-gap(3),            0;
is max-gap(1..9),         8;
is max-gap(1,0,3,-2,-4),  3;
is max-gap(-4,-2,-1,1,3), 3; 

sub max-gap(+$list) 
{ 
    $list.sort.rotor(2 => -1).map({ .tail - .head }).maxpairs.elems 
}    
