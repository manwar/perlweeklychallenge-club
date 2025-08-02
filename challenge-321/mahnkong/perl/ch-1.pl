use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@nums) {
    return undef if scalar(@nums) % 2 != 0;

    @nums = sort { $a <=> $b } @nums;
    my %avgs;
    while (scalar(@nums)) {
        $avgs{(shift(@nums) + pop(@nums))/2} = undef;
    }
    return scalar(keys(%avgs));
}

is(run(1, 2, 4, 3, 5, 6), 1, "Example 1");
is(run(0, 2, 4, 8, 3, 5), 2, "Example 2");
is(run(7, 3, 1, 0, 5, 9), 2, "Example 3");
