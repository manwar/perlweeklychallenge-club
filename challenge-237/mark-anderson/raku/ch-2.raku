#!/usr/bin/env raku
use Test;

is maximise-greatness(1,3,5,2,1,3,1),   4;
is maximise-greatness(1,2,3,4),         3;
is maximise-greatness(1,3,5,2,1,3,1,5), 5;
is maximise-greatness(4,5,5,5,5),       1;
is maximise-greatness(3,3,3,3,3),       0;

sub maximise-greatness(*@n)
{
    @n   .= sort;
    my $i = 0;

    sum do while @n[0] < @n[*-1] and $i < @n
    {
        $i++ while @n[0] == @n[$i];
        @n.shift;
        1
    }
}
