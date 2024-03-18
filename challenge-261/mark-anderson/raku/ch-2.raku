#!/usr/bin/env raku
use Test;

is multiply-by-two([5,3,6,1,12], 3), 24;
is multiply-by-two([1,2,4,3], 1),     8;
is multiply-by-two([5,6,7], 2),       2;

sub multiply-by-two(@a, $s)
{
    my $seq := $s, $s*2, $s*4, $s*8...@a.max;
    $s + (@a (&) $seq).keys.sum
}
