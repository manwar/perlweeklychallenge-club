use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($x, $y, $points) {
    my $smallest_distance;
    my $result = -1;

    for (my $i = 0; $i < scalar(@$points); $i++) {
        if ($x == $points->[$i]->[0] || $y == $points->[$i]->[1]) {
            my $distance = abs($x - $points->[$i]->[0]) + abs($y - $points->[$i]->[1]);

            if (! defined $smallest_distance || $smallest_distance > $distance) {
                $smallest_distance = $distance;
                $result = $i;
            }
        }
    }

    return $result;
}

is(run(3, 4, [[1, 2], [3, 1], [2, 4], [2, 3]]), 2, "Example 1");
is(run(2, 5, [[3, 4], [2, 3], [1, 5], [2, 5]]), 3, "Example 2");
is(run(1, 1, [[2, 2], [3, 3], [4, 4]]), -1, "Example 3");
is(run(0, 0, [[0, 1], [1, 0], [0, 2], [2, 0]]), 0, "Example 4");
is(run(5, 5, [[5, 6], [6, 5], [5, 4], [4, 5]]), 0, "Example 5");

