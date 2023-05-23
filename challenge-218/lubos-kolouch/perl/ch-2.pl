use strict;
use warnings;

# Function to flip a row or column
sub flip {
    my ($arr_ref) = @_;
    return [ map { 1 - $_ } @$arr_ref ];
}

# Function to convert binary to decimal
sub binary_to_decimal {
    my ($binary_ref) = @_;
    return oct("0b" . join('', @$binary_ref));
}

sub binary_matrix_score {
    my ($matrix_ref) = @_;
    my @matrix = @$matrix_ref;

    # First, optimize rows, make sure the first element is 1
    for my $row_ref (@matrix) {
        if ($row_ref->[0] == 0) {
            $row_ref = flip($row_ref);
        }
    }

    # Then, optimize columns excluding the first
    my $cols = @{$matrix[0]};
    my $rows = scalar @matrix;
    for my $col (1 .. $cols-1) {
        if (scalar(grep {$matrix[$_][$col] == 0} 0 .. $rows-1) > $rows / 2) {
            $_->[$col] = 1 - $_->[$col] for @matrix;
        }
    }

    # Calculate score
    my $score = 0;
    $score += binary_to_decimal($_) for @matrix;
    
    return $score;
}

# Test cases:
print binary_matrix_score([[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 0, 0]]);  # Output: 39
print "\n";
print binary_matrix_score([[0]]);  # Output: 1

