#! /usr/bin/raku

use Test;

plan 2;

is(twicelargest([2, 4, 1, 0]), 1, 'example 1');
is(twicelargest([1, 2, 3, 4]), -1, 'example 2');

sub twicelargest(@a) {
    my @p = @a.sort({$^b <=> $^a});
    if @p[0] >= 2 * @p[1] {
        for @a.kv -> $i, $c {
            if $c == @p[0] {
                return $i;
            }
        }
    }
    -1;
}
