#! /usr/bin/raku

use Test;

plan 2;

is(largestnumber([20, 3]), 320, 'example 1');
is(largestnumber([3, 30, 34, 5, 9]), 9534330, 'example 2');

sub largestnumber(@c) {
    my @b = @c.sort({"$^a$^b" cmp "$^b$^a"}).reverse;
    0 + join('', @b);
}
