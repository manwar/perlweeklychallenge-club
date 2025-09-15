use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my @sorted = sort {$a <=> $b} map { abs($_) } @ints;
    return $sorted[-2]*$sorted[-1] - $sorted[0]*$sorted[1];
}

is(run(5, 9, 3, 4, 6), 42, "Example 1");
is(run(1, -2, 3, -4), 10, "Example 2");
is(run(-3, -1, -2, -4), 10, "Example 3");
is(run(10, 2, 0, 5, 1), 50, "Example 4");
is(run(7, 8, 9, 10, 10), 44, "Example 5");
