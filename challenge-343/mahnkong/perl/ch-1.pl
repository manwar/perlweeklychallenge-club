use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@nums) {
    return (sort(map{abs($_)}@nums))[0];
}

is(run(4, 2, -1, 3, -2), 1, "Example 1");
is(run(-5, 5, -3, 3, -1, 1), 1, "Example 2");
is(run(7, -3, 0, 2, -8), 0, "Example 3");
is(run(-2, -5, -1, -8), 1, "Example 4");
is(run(-2, 2, -4, 4, -1, 1), 1, "Example 5");
