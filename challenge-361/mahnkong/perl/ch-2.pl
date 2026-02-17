use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@matrix) {
    my $rows = scalar(@matrix);
    my $cols = scalar(@{$matrix[0]});
    my $candidate;
    for (my $j = 0; $j < $cols; $j++) {
        my @candidates;
        for (my $i = 0; $i < $rows; $i++) {
            if ($matrix[$i][$j] == 0) {
                push @candidates, $i;
            }
        }
        if (scalar(@candidates) == 1) {
            $candidate = $candidates[0];
            last;
        }
    }

    return -1 unless defined $candidate;

    my $knows = 0;
    for (my $j = 0; $j < $cols; $j++) {
        $knows += $matrix[$candidate][$j];
    }
    return $knows ? -1 : $candidate;
}

is(
    run(
        [0,0,0,0,1,0],
        [0,0,0,0,1,0],
        [0,0,0,0,1,0],
        [0,0,0,0,1,0],
        [0,0,0,0,0,0],
        [0,0,0,0,1,0],
    ), 4, 'Example 1'
);

is(
    run(
        [0,1,0,0],
        [0,0,1,0],
        [0,0,0,1],
        [1,0,0,0],
    ), -1, 'Example 2'
);

is(
    run(
        [0,0,0,0,0],
        [1,0,0,0,0],
        [1,0,0,0,0],
        [1,0,0,0,0],
        [1,0,0,0,0],
    ), 0, 'Example 3'
);

is(
    run(
        [0,1,0,1,0,1],
        [1,0,1,1,0,0],
        [0,0,0,1,1,0],
        [0,0,0,0,0,0],
        [0,1,0,1,0,0],
        [1,0,1,1,0,0],
    ), 3, 'Example 4'
);

is(
    run(
        [0,1,1,0],
        [1,0,1,0],
        [0,0,0,0],
        [0,0,0,0],
    ), -1, 'Example 5'
);

is(
    run(
        [0,0,1,1],
        [1,0,0,0],
        [1,1,0,1],
        [1,1,0,0],
    ), -1, 'Example 6'
);

