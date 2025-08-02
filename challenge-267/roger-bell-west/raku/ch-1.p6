#! /usr/bin/raku

use Test;

plan 3;

is(productsign([-1, -2, -3, -4, 3, 2, 1]), 1, 'example 1');
is(productsign([1, 2, 0, -2, -1]), 0, 'example 2');
is(productsign([-1, -1, 1, -1, 2]), -1, 'example 3');

sub productsign(@a) {
    my $out = 1;
    for @a -> $t {
        if ($t < 0) {
            $out = -$out;
        } elsif ($t == 0) {
            $out = 0;
            last;
        }
    }
    return $out;
}
