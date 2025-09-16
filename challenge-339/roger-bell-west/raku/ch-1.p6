#! /usr/bin/raku

use Test;

plan 5;

is(maxdiff([5, 9, 3, 4, 6]), 42, 'example 1');
is(maxdiff([1, -2, 3, -4]), 10, 'example 2');
is(maxdiff([-3, -1, -2, -4]), 10, 'example 3');
is(maxdiff([10, 2, 0, 5, 1]), 50, 'example 4');
is(maxdiff([7, 8, 9, 10, 10]), 44, 'example 5');

sub maxdiff(@a) {
    my $md = 0;
    for 0 .. @a.elems - 2 -> $w {
        for $w + 1 .. @a.elems - 1 -> $x {
            for $w + 1 .. @a.elems - 2 -> $y {
                if ($y != $x) {
                    for $y + 1 .. @a.elems - 1 -> $z {
                        if ($z != $x) {
                            my $v = abs(@a[$w] * @a[$x] - @a[$y] * @a[$z]);
                            $md = max($md, $v);
                        }
                    }
                }
            }
        }
    }
    $md;
}
