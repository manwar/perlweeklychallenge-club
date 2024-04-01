#! /usr/bin/raku

use Test;

plan 3;

is(multiplybytwo([5, 3, 6, 1, 12], 3), 24, 'example 1');
is(multiplybytwo([1, 2, 4, 3], 1), 8, 'example 2');
is(multiplybytwo([5, 6, 7], 2), 2, 'example 3');

sub multiplybytwo(@a, $start) {
    my %p = Set(@a);
    my $v = $start;
    while (%p{$v}:exists) {
        $v *= 2;
    }
    return $v;
}
