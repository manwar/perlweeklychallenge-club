#!/usr/bin/perl
use strict;
use warnings;

sub min_max {
    my ($aref) = @_;

    # Check for empty input
    return [] unless @$aref;

    # Validate that all inputs are non-negative integers
    for (@$aref) {
        die "Input must contain only non-negative integers\n" unless /^\d+$/;
    }

    my @sorted = sort @$aref;

    # Remove smallest and largest
    shift @sorted;    # Remove first (smallest)
    pop @sorted;      # Remove last (largest)

    # Return result as array ref or empty array ref
    return \@sorted;
}

# Tests

my @ints;
my $result;

# Example 1
@ints = (3, 2, 1, 4);
$result = min_max(\@ints); # Output: (2, 3)
if (@$result) {
    print "(", join(', ', @$result), ")\n";
} else {
    print "-1\n";
}

# Example 2
@ints = (3, 1);
$result = min_max(\@ints); # Output: -1
if (@$result) {
    print "(", join(', ', @$result), ")\n";
} else {
    print "-1\n";
}

# Example 3
@ints = (2, 1, 3);
$result = min_max(\@ints); # Output: (2)
if (@$result) {
    print "(", join(', ', @$result), ")\n";
} else {
    print "-1\n";
}
