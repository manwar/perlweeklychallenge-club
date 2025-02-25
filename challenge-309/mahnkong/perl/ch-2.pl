use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my $min_diff = undef;
    for (my $i = 0; $i < scalar(@ints); $i++) {
        for (my $j = $i + 1 ; $j < scalar(@ints); $j++) {
            my $diff = abs($ints[$i] - $ints[$j]);
            $min_diff = $diff if !defined $min_diff || $min_diff > $diff;
        }
    }
    return $min_diff;
}

is(run(1, 5, 8, 9), 1, "Example 1");
is(run(9, 4, 1, 7), 2, "Example 2");
