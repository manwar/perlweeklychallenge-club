use strict;
use warnings;

sub min_sum_path {
    my ($matrix) = @_;
    my $rows = @$matrix;
    my $columns = @{$matrix->[0]};

    for my $i (1 .. $rows - 1) {
        $matrix->[$i][0] += $matrix->[$i - 1][0];
    }

    for my $j (1 .. $columns - 1) {
        $matrix->[0][$j] += $matrix->[0][$j - 1];
    }

    for my $i (1 .. $rows - 1) {
        for my $j (1 .. $columns - 1) {
            $matrix->[$i][$j] += min($matrix->[$i - 1][$j], $matrix->[$i][$j - 1]);
        }
    }

    return $matrix->[-1][-1];
}

sub min {
    my ($a, $b) = @_;
    return $a < $b ? $a : $b;
}

my $matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
];

print "Minimum sum path: ", min_sum_path($matrix), "\n";  # Output: 21

