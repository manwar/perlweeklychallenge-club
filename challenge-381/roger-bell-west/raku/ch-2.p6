#! /usr/bin/raku

use Test;

plan 5;

is(smallergreaterelement([2, 4]), 0, 'example 1');
is(smallergreaterelement([1, 1, 1, 1]), 0, 'example 2');
is(smallergreaterelement([1, 1, 4, 8, 12, 12]), 2, 'example 3');
is(smallergreaterelement([3, 6, 6, 9]), 2, 'example 4');
is(smallergreaterelement([0, -5, 10, -2, 4]), 3, 'example 5');

sub smallergreaterelement(@a) {
    my $mn = min(@a);
    my $mx = max(@a);
    @a.grep({$_ != $mn && $_ != $mx}).elems;
}
