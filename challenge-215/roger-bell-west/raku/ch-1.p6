#! /usr/bin/raku

use Test;

plan 3;

is(oddoneout(['abc', 'xyz', 'tsu']), 1, 'example 1');
is(oddoneout(['rat', 'cab', 'dad']), 3, 'example 2');
is(oddoneout(['x', 'y', 'z']), 0, 'example 3');

sub oddoneout(@a) {
    my $ct = 0;
    for @a -> $s {
        my $t = $s.comb.sort.join('');
        if ($s ne $t) {
            $ct++;
        }
    }
    return $ct;
}
