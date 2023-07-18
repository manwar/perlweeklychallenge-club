#! /usr/bin/raku

use Test;

plan 3;

is(zeroarray([1, 5, 0, 3, 5]), 3, 'example 1');
is(zeroarray([0]), 0, 'example 2');
is(zeroarray([2, 1, 4, 0, 3]), 4, 'example 3');

sub zeroarray(@a) {
    my $s = SetHash.new(@a);
    $s{0}:delete;
    return $s.elems;
}
