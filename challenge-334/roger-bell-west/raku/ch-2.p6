#! /usr/bin/raku

use Test;

plan 5;

is(nearestvalidpoint(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]), 2, 'example 1');
is(nearestvalidpoint(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]), 3, 'example 2');
is(nearestvalidpoint(1, 1, [[2, 2], [3, 3], [4, 4]]), -1, 'example 3');
is(nearestvalidpoint(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]), 0, 'example 4');
is(nearestvalidpoint(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]), 0, 'example 5');

sub nearestvalidpoint($x, $y, @points) {
    my $ix = -1;
    my $minmhd = -1;
    for @points.kv -> $i, @p {
        if (@p[0] == $x || @p[1] == $y) {
            my $mhd = abs(@p[0] - $x) + abs(@p[1] - $y);
            if ($minmhd == -1 || $mhd < $minmhd) {
                $minmhd = $mhd;
                $ix = $i;
            }
        }
    }
    $ix;
}
