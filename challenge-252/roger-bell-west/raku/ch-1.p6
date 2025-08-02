#! /usr/bin/raku

use Test;

plan 2;

is(specialnumbers([1, 2, 3, 4]), 21, 'example 1');
is(specialnumbers([2, 7, 1, 19, 18, 3]), 63, 'example 2');

sub specialnumbers(@a) {
    my $t = 0;
    for (0 .. @a.end) -> $i {
        if (@a.elems % ($i + 1) == 0) {
            $t += @a[$i] * @a[$i];
        }
    }
    return $t;
}
