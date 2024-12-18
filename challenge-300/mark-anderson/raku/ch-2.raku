#!/usr/bin/env raku
use Test;

is nested-array(5,4,0,3,1,6,2),        4;
is nested-array(0,1,2),                1;
is nested-array(3,4,5,2,9,1,7,0,6,8), 10;
is nested-array(0,1,8,5,4,9,3,2,7,6),  4;

sub nested-array(+@ints)
{
    .max given gather for ^@ints  
    {
        my $i = $_;
        {
            temp @ints;

            take .elems given do loop
            {
                $i = @ints[$i]:delete // last
            }
        }
    } 
}
