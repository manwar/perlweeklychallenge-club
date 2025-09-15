use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@gain) {
    my $peak = 0;
    my $current = 0;

    for (my $i = 0; $i <= $#gain; $i++) {
        $current += $gain[$i];
        $peak = $current if $current > $peak;
    }

    return $peak;
}

is(run(-5, 1, 5, -9, 2), 1, "Example 1");
is(run(10, 10, 10, -25), 30, "Example 2");
is(run(3, -4, 2, 5, -6, 1), 6, "Example 2");
is(run(-1, -2, -3, -4), 0, "Example 4");
is(run(-10, 15, 5), 10, "Example 5");
