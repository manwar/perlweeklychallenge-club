use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($row, $col, $locations) {
    my @matrix;
    my $result = 0;

    # Setup
    foreach (1..$row) {
        my @col;
        foreach (1..$col) {
            push @col, 0;
        }
        push @matrix, [ @col ];
    }

    foreach my $location (@$locations) {
        for (my $i = 0; $i <= $#matrix; $i++) {
            if ($i == $location->[0]) {
                my $row = $matrix[$i];
                for (my $j = 0; $j <= $#$row; $j++) {
                    $row->[$j] += 1;
                }
            }
            $matrix[$i]->[$location->[1]] += 1;
        }
    }

    foreach my $row (@matrix) {
        foreach my $item (@$row) {
            $result += 1 if $item % 2 != 0;
        }
    }

    return $result;
}

is(run(2, 3, [[0,1],[1,1]]), 6, "Example 1");
is(run(2, 2, [[1,1],[0,0]]), 0, "Example 2");
is(run(3, 3, [[0,0],[1,2],[2,1]]), 0, "Example 3");
is(run(1, 5, [[0,2],[0,4]]), 2, "Example 4");
is(run(4, 2, [[1,0],[3,1],[2,0],[0,1]]), 8, "Example 5");
