#! /usr/bin/raku

use Test;

plan 5;

is-deeply(shiftgrid([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1), [[9, 1, 2], [3, 4, 5], [6, 7, 8]], 'example 1');
is-deeply(shiftgrid([[10, 20], [30, 40]], 1), [[40, 10], [20, 30]], 'example 2');
is-deeply(shiftgrid([[1, 2], [3, 4], [5, 6]], 1), [[6, 1], [2, 3], [4, 5]], 'example 3');
is-deeply(shiftgrid([[1, 2, 3], [4, 5, 6]], 5), [[2, 3, 4], [5, 6, 1]], 'example 4');
is-deeply(shiftgrid([[1, 2, 3, 4],], 1), [[4, 1, 2, 3],], 'example 5');

sub shiftgrid(@gi, $k0) {
    my @wi;
    for @gi -> @x {
        @wi.append(@x);
    }
    my $k = $k0 % @wi.elems;
    my @wo = @wi[@wi.elems - $k .. @wi.end];
    @wo.append(@wi[0 .. @wi.elems - $k - 1]);
    @wo.rotor(@gi[0].elems).map({$_.Array}).Array;
}
