#!/usr/bin/env raku
use Test;

# with help from https://www.youtube.com/watch?v=fevOTPYq2p8

is delete-and-earn(3,4,2),                 6;
is delete-and-earn(2,2,3,3,3,4),           9;
is delete-and-earn(3,4,2,7,6,9,6,13,7,8), 42;

sub delete-and-earn(+@ints)
{
    my $bag = @ints.Bag;
    my @max = 0, $bag{1};

    for (0..@ints.max).rotor(3 => -2) -> ($a,$b,$c)
    {
        @max[$c] = max @max[$b], @max[$a] + $c * $bag{$c}
    }
  
    return @max[*-1]
}
