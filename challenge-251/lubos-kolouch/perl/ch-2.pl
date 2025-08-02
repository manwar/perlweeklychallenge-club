use strict;
use warnings;
use List::Util qw(min);
use List::MoreUtils qw(first_index all);

sub lucky_number {
    my @matrix = @_;
    for my $i (0..$#matrix) {
        my $min_row = min(@{$matrix[$i]});
        my $min_index = first_index { $_ == $min_row } @{$matrix[$i]};
        if (all { $matrix[$_][$min_index] <= $min_row } 0..$#matrix) {
            return $min_row;
        }
    }
    return -1;
}

# Example usage
my @matrix1 = ([3, 7, 8], [9, 11, 13], [15, 16, 17]);
print lucky_number(@matrix1) . "\n";  # Output: 15

my @matrix2 = ([1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]);
print lucky_number(@matrix2) . "\n";  # Output: 12

my @matrix3 = ([7, 8], [1, 2]);
print lucky_number(@matrix3) . "\n";  # Output: 7
