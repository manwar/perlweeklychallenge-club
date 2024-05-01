
#!/usr/bin/perl

use strict;
use warnings;

# Input array and target
my @ints = (1, 5, 3, 2, 4, 2);
my $k = 2;

# Sorta the array
my @sorted = sort @ints;

# Initialize an empty array to store the indices
my @indices;

# Iterate over the sorted array
for (my $i = 0; $i < @sorted; $i++) {
    # If the current element is equal to the target
    if ($sorted[$i] == $k) {
        # Add the index to the array
        push @indices, $i;
    }
}

# Print the indices
print "The indices where the element is $k are: @indices\n";

