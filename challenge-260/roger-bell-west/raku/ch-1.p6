#! /usr/bin/raku

use Test;

plan 3;

is(uniqueoccurrences([1, 2, 2, 1, 1, 3]), 1, 'example 1');
is(uniqueoccurrences([1, 2, 3]), 0, 'example 2');
is(uniqueoccurrences([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]), 1, 'example 3');

sub uniqueoccurrences(@a) {
    my %c;
    @a.map({%c{$_}++});
    if (Set(%c.values).elems == %c.elems) {
        return 1;
    } else {
        return 0;
    }
}
