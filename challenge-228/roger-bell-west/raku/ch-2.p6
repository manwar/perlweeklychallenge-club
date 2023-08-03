#! /usr/bin/raku

use Test;

plan 2;

is(emptyarray([3, 4, 2]), 5, 'example 1');
is(emptyarray([1, 2, 3]), 3, 'example 2');

sub emptyarray(@a0) {
    my $t = 0;
    my @a = @a0;
    while @a.elems > 0 {
        my $mn = @a.min;
        for 0..@a.end -> $i {
            if (@a[$i] == $mn) {
                $t += $i + 1;
                @a.splice($i, 1);
                last;
            }
        }
    }
    return $t;
}
