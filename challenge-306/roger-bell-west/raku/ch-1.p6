#! /usr/bin/raku

use Test;

plan 2;

is(oddsum([2, 5, 3, 6, 4]), 77, 'example 1');
is(oddsum([1, 3]), 4, 'example 2');

sub oddsum(@a) {
    my $out = @a.sum;
    my $l = 3;
    while ($l <= @a.elems) {
        for @a.rotor($l => -($l - 1)) -> @s {
            $out += @s.sum;
        }
        $l += 2;
    }
    $out;
}
