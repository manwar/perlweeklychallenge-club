#! /usr/bin/raku

use Test;

plan 5;

is(samerowcolumn([[1, 2, 3, 4], [2, 3, 4, 1], [3, 4, 1, 2], [4, 1, 2, 3]]), True, 'example 1');
is(samerowcolumn([[1,],]), True, 'example 2');
is(samerowcolumn([[1, 2, 5], [5, 1, 2], [2, 5, 1]]), False, 'example 3');
is(samerowcolumn([[1, 2, 3], [1, 2, 3], [1, 2, 3]]), False, 'example 4');
is(samerowcolumn([[1, 2, 3], [3, 1, 2], [3, 2, 1]]), False, 'example 5');

sub samerowcolumn(@a) {
    for @a -> @row {
        my %notfound = SetHash.new(1 .. @row.elems);
        for @row -> $n {
            %notfound{$n}:delete;
        }
        if (%notfound.elems > 0) {
            return False;
        }
    }
    for (0 .. @a[0].end) -> $coln {
        my %notfound = SetHash.new(1 .. @a.elems);
        for @a -> @row {
            %notfound{@row[$coln]}:delete;
        }
        if (%notfound.elems > 0) {
            return False;
        }
    }
    True;
}
