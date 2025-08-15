use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($ints, $x, $y) {
    my $sum = 0;
    foreach my $i (@$ints[$x..$y]) {
        $sum += $i;
    }
    return $sum;
}

is(run([-2, 0, 3, -5, 2, -1], 0, 2), 1, "Example 1");
is(run([1, -2, 3, -4, 5], 1, 3), -3, "Example 2");
is(run([1, 0, 2, -1, 3], 3, 4), 2, "Example 3");
is(run([-5, 4, -3, 2, -1, 0], 0, 3), -2, "Example 4");
is(run([-1, 0, 2, -3, -2, 1], 0, 2), 1, "Example 5");
