use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my $positive = 0;
    my $negative = 0;

    foreach my $i (@ints) {
        $positive++ if $i > 0;
        $negative++ if $i < 0;
    }
    return $positive > $negative ? $positive : $negative;
}

is(run(-3, -2, -1, 1, 2, 3), 3, "Example 1");
is(run(-2, -1, 0, 0, 1), 2, "Example 2");
is(run(1, 2, 3, 4), 4, "Example 3");
