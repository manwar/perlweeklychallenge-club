use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my $smallest_gap = undef;
    my $element      = undef;
    for (my $i = 0; $i < $#ints; $i++) {
        my $gap = $ints[$i+1] - $ints[$i];
        if (! defined $smallest_gap || $smallest_gap > $gap) {
            $smallest_gap = $gap;
            $element = $ints[$i+1];
        }
    }
    return $element;
}

is(run(2, 8, 10, 11, 15), 11, "Example 1");
is(run(1, 5, 6, 7, 14), 6, "Example 2");
is(run(8, 20, 25, 28), 28, "Example 3");
