#!/usr/bin/env raku
use Test;

is multiply-by-two([5,3,6,1,12], 3), 24;
is multiply-by-two([1,2,4,3], 1),     8;
is multiply-by-two([5,6,7], 2),       2;

say multiply-by-two((1..100000).roll(100000), 5);

sub multiply-by-two(@a, $s)
{
    my $seq := $s, $s*2, $s*4, $s*8...@a.max;
    my @r = (@a (&) $seq.cache).keys.sort;
    
    my @i = gather for @r Z== $seq
    {
        last if .not; 
        take $++
    }

    return $s unless @i; 
    return @r[@i.tail] * 2
}
