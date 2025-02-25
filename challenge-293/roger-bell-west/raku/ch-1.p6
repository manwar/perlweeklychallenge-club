#! /usr/bin/raku

use Test;

plan 2;

is(similardominoes([[1, 3], [3, 1], [2, 4], [6, 8]]), 2, 'example 1');
is(similardominoes([[1, 2], [2, 1], [1, 1], [1, 2], [2, 2]]), 3, 'example 2');

sub dvalue(@a) {
    if (@a[0] < @a[1]) {
        @a[0] * 64 + @a[1];
    } else {
        @a[0] + @a[1] * 64;
    }
}

sub similardominoes(@a) {
    my %c = @a.map({dvalue($_)}).Bag;
    my $t = 0;
    for %c.values -> $v {
        if ($v > 1) {
            $t += $v;
        }
    }
    return $t;
}
