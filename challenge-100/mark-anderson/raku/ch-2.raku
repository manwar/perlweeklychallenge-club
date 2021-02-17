#!/usr/bin/env raku

use Test;
plan 4;

is min-triangle-sum([[1], [2,4], [6,4,9], [5,1,7,2]]),  8;
is min-triangle-sum([[3], [3,1], [5,2,3], [4,3,1,3]]),  7;
is min-triangle-sum([[2], [3,4], [6,5,7], [4,1,8,3]]), 11;  
is min-triangle-sum([[7], [3,6], [6,4,9], [5,1,7,2]]), 15;

sub min-triangle-sum(@triangle) 
{
    my @a = (flat roundrobin @triangle[1]<>, @triangle[0]<>).rotor(2 => -1);
    my $head = @a.shift.sum;
    my $tail = @a.pop.sum;
    my @mid = map -> $a, $b { $a.sum min $b.sum }, @a;
    shift @triangle; 
    @triangle[0] = [$head, |@mid, $tail];
    min-triangle-sum(@triangle) if @triangle > 1;
    @triangle[0].min;
}
