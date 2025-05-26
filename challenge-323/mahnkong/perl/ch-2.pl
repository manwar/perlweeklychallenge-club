use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($income, @tax) {
    my $result = 0;

    for (my $i = 0; $i <= $#tax; $i++) {
        my $income_part = ($income >= $tax[$i]->[0] ? $tax[$i]->[0] : $income) - ($i > 0 ? $tax[$i-1]->[0] : 0);
        $result += $income_part * ($tax[$i]->[1] / 100) if $income_part >= 0;
    }
    return $result;
}

is(run(10, ([3, 50], [7, 10], [12, 25])), 2.65, "Example 1");
is(run(2, ([1, 0], [4, 25], [5, 50])), 0.25, "Example 2");
is(run(0, ([2, 50])), 0, "Example 3");
