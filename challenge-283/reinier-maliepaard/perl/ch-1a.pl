#!/usr/bin/perl
use strict;
use warnings;

# Define a subroutine to find the unique value in an array
sub find_unique_value {

    # Check if the input is an array reference
    my ($array_ref) = @_;
    if (!defined($array_ref) || ref($array_ref) ne 'ARRAY') {
        die "Error: Input must be an array reference\n";
    }

    # Check if the array is empty
    if (@$array_ref == 0) {
        die "Error: Input array is empty\n";
    }

    # Check if all elements in the array are integers
    foreach my $value (@$array_ref) {
        if (!defined($value) || $value!~ /^\d+$/) {
            die "Error: All elements in the input array must be integers\n";
        }
    }

    # Create an empty hash to store the counts of each value
    my %counts;

    # Iterate over the array and increment the count for each value
    $counts{$_}++ for @$array_ref;

    # Use the "grep" function to find the key with a count of 1
    # The "grep" function returns a list of values that match the condition
    # In this case, we're looking for the key(s) in the %counts hash that have a value of 1

    my $unique_value = (grep { $counts{$_} == 1 } keys %counts)[0];

    # The "[0]" is used to extract the first (and hopefully only) element from the list returned by "grep"
    # This is because we expect there to be only one unique value in the array
    # If there are multiple unique values, this code will only return the first one it finds
    # If there are no unique values, this code will return an undefined value

    # Check if a unique value was found
    if (!defined($unique_value)) {
        die "Error: No unique value found in the input array\n";
    }

    return $unique_value;
}

# Example usage:

my @array = (1, 2, 2, 3, 3, 4, 4, 5, 5, 6);
my $unique_value = find_unique_value(\@array);
print "The unique value is: $unique_value\n"; # Output: 1
