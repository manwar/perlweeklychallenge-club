#! /usr/bin/raku

use Test;

plan 2;

is(arithmetictriplets([0, 1, 4, 6, 7, 10], 3), 2, 'example 1');
is(arithmetictriplets([4, 5, 6, 7, 8, 9], 2), 2, 'example 2');

sub arithmetictriplets(@a, $diff) {
    my $vs = @a.Set;
    return @a.grep({($vs{$_+$diff}:exists) && ($vs{$_+$diff*2}:exists)}).elems;
}
