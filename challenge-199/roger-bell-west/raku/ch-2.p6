#! /usr/bin/raku

use Test;

plan 2;

is(goodtriplets([3, 0, 1, 1, 9, 7], 7, 2, 3), 4, 'example 1');
is(goodtriplets([1, 1, 2, 2, 3], 0, 0, 1), 0, 'example 2');

sub goodtriplets(@a, $x, $y, $z) {
    my $c = 0;
    for (0..@a.end - 2) -> $i {
        for ($i+1..@a.end - 1) -> $j {
            if (abs(@a[$i] - @a[$j]) <= $x) {
                for ($j+1..@a.end) -> $k {
                    if (abs(@a[$j] - @a[$k]) <= $y &&
                        abs(@a[$i] - @a[$k]) <= $z) {
                        $c++;
                    }
                }
            }
        }
    }
    return $c;
}
