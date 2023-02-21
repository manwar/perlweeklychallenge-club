#! /usr/bin/raku

use Test;

plan 3;

is(thirdhighest([5, 3, 4]), 3, 'example 1');
is(thirdhighest([5, 6]), 6, 'example 2');
is(thirdhighest([5, 4, 4, 3]), 3, 'example 3');

sub thirdhighest(@l) {
    my @v = @l.Set.keys.sort.reverse;
    if (@v.elems == 0) {
        return 0;
    } elsif (@v.elems <= 2) {
        return @v[0];
    } else {
        return @v[2];
    }
}
