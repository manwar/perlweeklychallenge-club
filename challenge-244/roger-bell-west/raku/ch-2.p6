#! /usr/bin/raku

use Test;

plan 1;

is(grouphero([2, 1, 4]), 141, 'example 1');

sub grouphero(@nums0) {
    my @nums = @nums0.sort({$^a <=> $^b});
    my $sum = 0;
    for (1 .. @nums.elems) -> $l {
        for combinations(@nums, $l) -> @c {
            $sum += @c[*-1] * @c[*-1] * @c[0];
        }
    }
    return $sum;
}
