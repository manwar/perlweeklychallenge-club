use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@coordinates) {
    my $diff_x;
    my $diff_y;

    return 1 if scalar(@coordinates) < 2;

    my ($x0, $y0) = @{$coordinates[0]};
    my ($x1, $y1) = @{$coordinates[1]};

    for (my $i = 2; $i < scalar(@coordinates); $i++) {
        my ($x, $y) = @{$coordinates[$i]};

        return 0 if ($y1-$y0)*($x-$x0) != ($y-$y0)*($x1-$x0);
    }
    return 1;
}

is(run([2, 1], [2, 3], [2, 5]), 1, "Example 1");
is(run([1, 4], [3, 4], [10, 4]), 1, "Example 2");
is(run([0, 0], [1, 1], [2, 3]), 0, "Example 3");
is(run([1, 1], [1, 1], [1, 1]), 1, "Example 4");
is(run([1000000, 1000000], [2000000, 2000000], [3000000, 3000000]), 1, "Example 5");
