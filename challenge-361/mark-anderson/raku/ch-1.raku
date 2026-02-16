#!/usr/bin/env raku
use Test;

is-deeply zeckendorf(4),   (3,1);
is-deeply zeckendorf(12),  (8,3,1);
is-deeply zeckendorf(20),  (13,5,2);
is-deeply zeckendorf(96),  (89,5,2);
is-deeply zeckendorf(100), (89,8,3);

is-deeply zeckendorf(1),   (1,);
is-deeply zeckendorf(89),  (89,);

my $googol = 10**100;
is zeckendorf($googol).sum, $googol;

sub zeckendorf($i is copy)
{
    do while $i
    {
        my @f = 0,1,*+*...*+* > $i;
        $i -= @f.tail;
        @f.tail
    } 
}
