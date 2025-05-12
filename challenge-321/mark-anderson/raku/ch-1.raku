#!/usr/bin/env raku
use Test;

is distinct-average(1,2,4,3,5,6), 1;
is distinct-average(0,2,4,8,3,5), 2;
is distinct-average(7,3,1,0,5,9), 2;

sub distinct-average(+@nums)
{
    .unique.elems given @nums.map(
    {
        my $min = @nums.min(:kv);
        my $max = @nums.max(:kv);

        @nums[$min[0], $max[0]]:delete;

        ($min[1] + $max[1]) / 2
    })
}
