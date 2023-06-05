#! /usr/bin/raku

use Test;

plan 2;

is-deeply(sortedsquares([-2, -1, 0, 3, 4]), [0, 1, 4, 9, 16], 'example 1');
is-deeply(sortedsquares([5, -4, -1, 3, 6]), [1, 9, 16, 25, 36], 'example 2');

sub sortedsquares(@lst) {
    return @lst.map({$_ * $_}).sort({$^a <=> $^b}).Array;
}
