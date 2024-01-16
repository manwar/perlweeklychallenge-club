sub lucky-number(@matrix) {
    for @matrix.kv -> $i, @row {
        my $min-row = @row.min;
        my $min-index = @row.first($min-row, :k);
        if all(@matrix.map(*[$min-index])) <= $min-row {
            return $min-row;
        }
    }
    return -1;
}

# Example usage
my @matrix1 = ([3, 7, 8], [9, 11, 13], [15, 16, 17]);
say lucky-number(@matrix1);  # Output: 15

my @matrix2 = ([1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]);
say lucky-number(@matrix2);  # Output: 12

my @matrix3 = ([7, 8], [1, 2]);
say lucky-number(@matrix3);  # Output: 7
