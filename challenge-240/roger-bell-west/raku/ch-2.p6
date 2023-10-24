#! /usr/bin/raku

use Test;

plan 2;

is-deeply(buildarray([0, 2, 1, 5, 3, 4]), [0, 1, 2, 4, 5, 3], 'example 1');
is-deeply(buildarray([5, 0, 1, 2, 3, 4]), [4, 5, 0, 1, 2, 3], 'example 2');

sub buildarray(@a) {
    return [@a.map({@a[$_]})];
}
    
