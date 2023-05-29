use strict;
use warnings;

sub sorted_squares {
    my @nums = @_;
    return sort {$a <=> $b} map { $_**2 } @nums;
}

# Test
print join(", ", sorted_squares(-2, -1, 0, 3, 4)), "\n";  # Output: 0, 1, 4, 9, 16
print join(", ", sorted_squares(5, -4, -1, 3, 6)), "\n";  # Output: 1, 9, 16, 25, 36

