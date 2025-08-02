#! /usr/bin/raku

use Test;

plan 3;

is-deeply(mergeitems([[1, 1], [2, 1], [3, 2]], [[2, 2], [1, 3]]), [[1, 4], [2, 3], [3, 2]], 'example 1');
is-deeply(mergeitems([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]]), [[1, 8], [2, 3], [3, 3]], 'example 2');
is-deeply(mergeitems([[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]]), [[1, 1], [2, 9], [3, 3]], 'example 3');

sub mergeitems(@a, @b) {
    my %c;
    for (@a, @b) -> @v {
        for @v -> @w {
            %c{@w[0]} += @w[1];
        }
    }
    return Array(%c.keys.sort({$^a <=> $^b}).map({[0 + $_, %c{$_}]}));
}
