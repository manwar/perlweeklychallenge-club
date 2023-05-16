use strict;
use warnings;
use Data::Dumper;

sub zero_matrix {
    my ($matrix) = @_;
    my @zero_rows;
    my @zero_cols;

    # Identify rows and columns that should be zeroed out
    for my $i (0 .. scalar @$matrix - 1) {
        for my $j (0 .. scalar @{$matrix->[$i]} - 1) {
            if ($matrix->[$i][$j] == 0) {
                push @zero_rows, $i;
                push @zero_cols, $j;
            }
        }
    }

    # Zero out identified rows and columns
    for my $i (@zero_rows) {
        for my $j (0 .. scalar @{$matrix->[$i]} - 1) {
            $matrix->[$i][$j] = 0;
        }
    }

    for my $j (@zero_cols) {
        for my $i (0 .. scalar @$matrix - 1) {
            $matrix->[$i][$j] = 0;
        }
    }

    return $matrix;
}

my $matrix1 = [[1, 0, 1], [1, 1, 1], [1, 1, 1]];
my $matrix2 = [[1, 0, 1], [1, 1, 1], [1, 0, 1]];
print Dumper(zero_matrix($matrix1));
print Dumper(zero_matrix($matrix2));

