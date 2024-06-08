#!/usr/bin/env
use Test;

is  magic-number((3,7,5), (9,5,7)), 2;
is  magic-number((1,2,1), (5,4,4)), 3;
is  magic-number((2,),    (5,)),    3;
nok magic-number((3,7,5), (9,6,7));

sub magic-number(@x, @y)
{
    my @r = @y.sort >>-<< @x.sort;
    return .head if .elems == 1 given @r.squish;
    return False
}    
