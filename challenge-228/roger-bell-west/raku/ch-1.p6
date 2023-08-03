#! /usr/bin/raku

use Test;

plan 3;

is(uniquesum([2, 1, 3, 2]), 4, 'example 1');
is(uniquesum([1, 1, 1, 1]), 0, 'example 2');
is(uniquesum([2, 1, 3, 4]), 10, 'example 3');

sub uniquesum(@a) {
    my $c = bag(@a);
    return $c.keys.grep({$c{$_} == 1}).sum();
}
