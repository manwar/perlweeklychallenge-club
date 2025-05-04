#! /usr/bin/raku

use Test;

plan 3;

is(minimumcommon([1, 2, 3, 4], [3, 4, 5, 6]), 3, 'example 1');
is(minimumcommon([1, 2, 3], [2, 4]), 2, 'example 2');
is(minimumcommon([1, 2, 3, 4], [5, 6, 7, 8]), -1, 'example 3');

sub minimumcommon(@a, @b) {
    my %aa = Set.new(@a);
    my %bb = Set.new(@b);
    my %cc = %aa (&) %bb;
    if (%cc.elems > 0) {
        %cc.keys.min;
    } else {
        -1;
    }
}
