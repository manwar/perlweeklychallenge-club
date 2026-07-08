#!/usr/bin/env raku
use Test;

is smaller-greater-element(2,4),                             0;
is smaller-greater-element(1,1,1,1),                         0;
is smaller-greater-element(1,1,4,8,12,12),                   2;
is smaller-greater-element(3,6,6,9),                         2;
is smaller-greater-element(0,-5,10,-2,4),                    3;
is smaller-greater-element(3,3,3,6,6,9,9,9),                 2;
is smaller-greater-element(0,0,0,-5,10,-2,4,-5,-5,4,4,-2,7), 9;

sub smaller-greater-element(*@int)
{
    my $b = @int.Bag;
    ($b (-) ($b.min, $b.max)).total
}
