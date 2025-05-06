use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my $element_sum = 0;
    my $digit_sum = 0;

    foreach my $i (@ints) {
        $element_sum += $i;
        foreach my $p (split //, $i) {
            $digit_sum += $p;
        }
    }

    return abs($element_sum - $digit_sum);
}

is(run(1, 23, 4, 5), 18, "Example 1");
is(run(1, 2, 3, 4, 5), 0, "Example 2");
is(run(1, 2, 34), 27, "Example 3");
