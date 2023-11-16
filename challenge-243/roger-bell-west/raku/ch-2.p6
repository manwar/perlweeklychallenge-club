#! /usr/bin/raku

use Test;

plan 2;

is(floorsum([2, 5, 9]), 10, 'example 1');
is(floorsum([7, 7, 7, 7, 7, 7, 7]), 49, 'example 2');

sub floorsum(@a) {
    my $n = 0;
    for @a -> $iv {
        for @a -> $jv {
            $n += floor($iv / $jv);
        }
    }
    return $n;
}
