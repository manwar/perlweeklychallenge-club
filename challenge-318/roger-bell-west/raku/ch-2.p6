#! /usr/bin/raku

use Test;

plan 3;

is(reverseequals([3, 2, 1, 4], [1, 2, 3, 4]), True, 'example 1');
is(reverseequals([1, 3, 4], [4, 1, 3]), False, 'example 2');
is(reverseequals([2], [2]), True, 'example 3');

sub stringify(@a) {
    @a.map({"$_"}).join(";");
}

sub reverseequals(@a, @b) {
    if (stringify(@a) eq stringify(@b)) {
        return True;
    }
    for 0 .. @a.elems - 2 -> $i {
        for $i + 1 .. @a.elems - 1 -> $j {
            my @c = @a.clone;
            for $i .. $j -> $x {
                @c[$x] = @a[$j - ($x - $i)];
            }
            if (stringify(@c) eq stringify(@b)) {
                return True;
            }
        }
    }
    False;
}
