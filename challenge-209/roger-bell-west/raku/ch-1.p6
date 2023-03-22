#! /usr/bin/raku

use Test;

plan 2;

is(specialbitcharacters([1, 0, 0]), True, 'example 1');
is(specialbitcharacters([1, 1, 1, 0]), False, 'example 2');

sub specialbitcharacters(@a) {
    my $s = 0;
    for @a -> $v {
        if ($s == 1) {
            $s = 2;
        } else {
            $s = $v;
        }
    }
    return $s == 0;
}
