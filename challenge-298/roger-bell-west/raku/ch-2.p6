#! /usr/bin/raku

use Test;

plan 4;

is-deeply(rightinterval([[3, 4], [2, 3], [1, 2]]), [-1, 0, 1], 'example 1');
is-deeply(rightinterval([[1, 4], [2, 3], [3, 4]]), [-1, 2, -1], 'example 2');
is-deeply(rightinterval([[1, 2], ]), [-1], 'example 3');
is-deeply(rightinterval([[1, 4], [2, 2], [3, 4]]), [-1, 1, -1], 'example 4');

sub rightinterval(@a) {
    my @ss = @a.map({$_[0]});
    my @si = (0 .. @a.end).sort({@ss[$^a] <=> @ss[$^b]});
    my @out;
    for @a -> @l {
        my @ix = @si.grep({@ss[$_] >= @l[1]});
        if (@ix.elems > 0) {
            @out.push(@ix[0]);
        } else {
            @out.push(-1);
        }
    }
    @out;
}
