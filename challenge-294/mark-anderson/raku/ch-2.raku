#!/usr/bin/env raku
use Test;

# with help from https://www.geeksforgeeks.org/next-permutation/

is-deeply next-permutation(1,2,3),       [1,3,2];
is-deeply next-permutation(2,1,3),       [2,3,1];
is-deeply next-permutation(3,1,2),       [3,2,1];
is-deeply next-permutation(3,2,1),       [1,2,3];
is-deeply next-permutation(2,4,1,7,5,0), [2,4,5,0,1,7];

sub next-permutation(+@ints)
{
    my $pivot = @ints.rotor(2 => -1).first({ .[0] < .[1] }, :p:end);

    return @ints.reverse.Array unless $pivot;

    my $succ  = @ints.first({ $_ > $pivot.value.[0] }, :k:end);
    (@ints[$pivot.key,$succ]) = (@ints[$succ,$pivot.key]);
    @ints[$pivot.key.succ..*] .= reverse;

    return @ints
}
