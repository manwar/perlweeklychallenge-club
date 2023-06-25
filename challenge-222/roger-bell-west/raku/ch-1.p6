#! /usr/bin/raku

use Test;

plan 3;

is(matchingmembers([1, 1, 4, 2, 1, 3]), 3, 'example 1');
is(matchingmembers([5, 1, 2, 3, 4]), 0, 'example 2');
is(matchingmembers([1, 2, 3, 4, 5]), 5, 'example 3');

sub matchingmembers(@a) {
    my @b = @a.sort( {.Int} );
    my $o = 0;
    for (0 .. @b.end) -> $i {
        if (@a[$i] == @b[$i]) {
            $o++;
        }
    }
    return $o;
}
