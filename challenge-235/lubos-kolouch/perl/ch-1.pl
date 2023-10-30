use strict;
use warnings;

# Helper function to check if a list is strictly increasing
sub is_increasing {
    my @arr = @_;
    for my $i (1..$#arr) {
        return 0 if $arr[$i] <= $arr[$i-1];
    }
    return 1;
}

# Main function
sub can_be_made_increasing {
    my @ints = @_;
    for my $i (0..$#ints) {
        # Create a new list without the current integer
        my @new_list = @ints[0..$i-1, $i+1..$#ints];
        return 1 if is_increasing(@new_list);
    }
    return 0;
}

# Test the Perl solution
print can_be_made_increasing(0, 2, 9, 4, 6), "\n";  # Expected Output: 1 (true)
print can_be_made_increasing(5, 1, 3, 2), "\n";    # Expected Output: 0 (false)
print can_be_made_increasing(2, 2, 3), "\n";      # Expected Output: 1 (true)

