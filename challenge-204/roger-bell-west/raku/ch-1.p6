#! /usr/bin/raku

use Test;

plan 3;

is(monotonicarray([1, 2, 2, 3]), True, 'example 1');
is(monotonicarray([1, 3, 2]), False, 'example 2');
is(monotonicarray([6, 5, 5, 4]), True, 'example 3');

sub monotonicarray(@l) {
    my @d = @l.rotor(2 => -1).map({$_[1] - $_[0]});
    return @d.min * @d.max >= 0;
}
