#! /usr/bin/raku

use Test;

plan 2;

is(killandwin([2, 3, 1]), 6, 'example 1');
is(killandwin([1, 1, 2, 2, 2, 3]), 11, 'example 2');

sub killandwin(@a) {
    return @a.sum;
}
