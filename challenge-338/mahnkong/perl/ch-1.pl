use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@matrix) {
    my $highest_sum;
    foreach my $row (@matrix) {
        my $sum = 0;
        map { $sum += $_ } @$row;
        $highest_sum = $sum if !defined $highest_sum || $sum > $highest_sum;
    }
    return $highest_sum;
}

is(run([4, 4, 4, 4], [10, 0, 0, 0], [2,  2, 2, 9]), 16, "Example 1");
is(run([1, 5], [7, 3], [3, 5]), 10, "Example 2");
is(run([1, 2, 3], [3, 2, 1]), 6, "Example 3");
is(run([2, 8, 7], [7, 1, 3], [1, 9, 5]), 17, "Example 4");
is(run([10, 20, 30], [5, 5, 5], [0, 100, 0], [25, 25, 25]), 100, "Example 5");
