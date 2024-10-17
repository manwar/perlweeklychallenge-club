#!/usr/bin/perl
use strict;
use warnings;

sub find_middle_index {
    my (@ints) = @_;
    my $total_sum = 0;
    $total_sum += $_ for @ints;
    my $left_sum = 0;

    for my $i (0 .. $#ints) {
        # Right sum is total sum minus left sum and current element
        my $right_sum = $total_sum - $left_sum - $ints[$i];

        # Debug statements to trace computation (optional)
        # print "Index: $i, Left Sum: $left_sum, Current Element: $ints[$i], Right Sum: $right_sum\n";

        # Check if left sum equals right sum
        if ($left_sum == $right_sum) {
            return $i;
        }

        # Update left sum for next iteration
        $left_sum += $ints[$i];
    }

    # If no middle index is found
    return -1;
}

# Test Cases
print find_middle_index(2, 3, -1, 8, 4), "\n";  # Output: 3
print find_middle_index(1, -1, 4), "\n";        # Output: 2
print find_middle_index(2, 5), "\n";            # Output: -1

# Additional Test Cases
print find_middle_index(0), "\n";               # Output: 0 (Single element array)
print find_middle_index(), "\n";                # Output: -1 (Empty array)
print find_middle_index(0, 1, -1), "\n";        # Output: 0
print find_middle_index(1, -1, 0), "\n";        # Output: 2
print find_middle_index(1, 2, 3), "\n";         # Output: -1

