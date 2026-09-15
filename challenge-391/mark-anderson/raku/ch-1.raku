#!/usr/bin/env raku
use Test;

is array-median((2,),    (4,)),          3.0;
is array-median((1,2,3), (7,8,9,10)),    7.0;
is array-median((),      (10,20,30,40)), 25.0;
is array-median((100,),  (1..7)),        4.5;
is array-median((1,2,2), (2,2,3)),       2.0;

sub array-median(*@a) 
{
    @a .= sort;
    my $i = @a div 2;
    @a.end %% 2 ?? @a[$i] !! @a[$i-1,$i].sum / 2   
}
