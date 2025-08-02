#! /usr/bin/raku

use Test;

plan 3;

is-deeply(distributeelements([2, 1, 3, 4, 5]), [2, 3, 4, 5, 1], 'example 1');
is-deeply(distributeelements([3, 2, 4]), [3, 4, 2], 'example 2');
is-deeply(distributeelements([5, 4, 3, 8]), [5, 3, 4, 8], 'example 3');

sub distributeelements(@a) {
    my @x = @a[0];
    my @y = @a[1];
    for @a.skip(2) -> $n {
        if (@x[*-1] > @y[*-1]) {
            @x.push($n);
        } else {
            @y.push($n);
        }
    }
    @x.append(@y);
    return @x;
}
