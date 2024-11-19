#!/usr/bin/env raku
use Math::Combinatorics <partitions>;
use Test;

ok  square(1,2,2,2,1);
nok square(2,2,2,4);
nok square(2,2,2,2,4);
ok  square(3,4,1,4,3,1);

is-deeply sides(1,2,2,2,1),                     ((2,), (2,), (2,), (1,1));
is-deeply sides(3,4,1,4,3,1),                   ((4,), (4,), (1,3), (1,3));
is-deeply sides(1,1,2,5,6,1,1,2,3,1,1,3,2,5,2), ((3,6), (2,2,5), (2,2,5), (1,1,1,1,1,1,3));

sub square(+@ints)
{
    my $sum = @ints.sum;
    return False unless $sum %% 4;
    return @ints.max <= $sum div 4
}

sub sides(+@ints)
{
    my $sum = @ints.sum;
    return Empty unless $sum %% 4;
    return Empty unless @ints.max <= $sum div 4;

    my $bag = @ints.BagHash;

    return .List given gather for reverse partitions($sum div 4) -> $partition
    {
        last unless $bag;

        while all $bag{|$partition}
        {
            last unless $bag (>=) $partition;
            take $partition; 
            $bag (-)= $partition
        }
    }
}
