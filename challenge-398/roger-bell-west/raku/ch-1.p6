#! /usr/bin/raku

use Test;

plan 5;

is(divisibleaverage([18, 5, 7, 11]), 18, 'example 1');
is(divisibleaverage([6, 12, 18, 24, 30, 40]), 18, 'example 2');
is(divisibleaverage([3, 9, 15, 21, 27]), 0, 'example 3');
is(divisibleaverage([6, 12, 14, 20]), 9, 'example 4');
is(divisibleaverage([6, 6, 6, 12, 12]), 8, 'example 5');

sub divisibleaverage(@a) {
    my @b = @a.grep({ $_ % 6 == 0 });
    if (@b.elems == 0) {
        return 0;
    }
    floor(@b.sum / @b.elems + 0.5);
}
