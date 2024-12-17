#!/usr/bin/env raku
use Test;

is nested-array(5,4,0,3,1,6,2), 4;
is nested-array(0,1,2),         1;

sub nested-array(+@ints)
{
    my $i=0;

    .elems given do loop
    {
        $i = @ints[$i]:delete // last 
    }
}
