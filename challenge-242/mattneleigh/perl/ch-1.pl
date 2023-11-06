#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @array_pairs = (
    [
        [ 1, 2, 3 ],
        [ 2, 4, 6 ]
    ],
    [
        [ 1, 2, 3, 3 ],
        [ 1, 1, 2, 2 ]
    ]
);

print("\n");
foreach my $array_pair (@array_pairs){
    printf(
        "Input: \@arr1 = (%s)\n" .
        "       \@arr2 = (%s)\n" .
        "Output: (%s)\n\n",
        join(", ", @{$array_pair->[0]}),
        join(", ", @{$array_pair->[1]}),
        join(
            ", ",
            map(
                "[" . join(", ", @{$_}) . "]",
                find_missing_numbers_in_array_pair($array_pair)
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two arrays of integers, find those that are present in each array but
# missing in the other
# Takes one argument:
# * A ref to a pair of arrays of integers (e.g.
#       [
#           [ 1, 2, 3, 3 ],
#           [ 1, 1, 2, 2 ]
#       ]
#   )
# Returns:
# * A list of two arrays, each containing the integers from the corresponding
#   input array that were missing from the other array.  If a missing number
#   appeared more than once in its input array, it will only appear once in the
#   output array; if no numbers were missing, the output array will be empty
#   (e.g.
#       (
#           [ 3 ],
#           [ ]
#       )
#   )
################################################################################
sub find_missing_numbers_in_array_pair{

    my @missing = ([], []);

    # Loop over two pairs of indices
    for my $indices ([0, 1], [1, 0]){
        # Make a lookup table so we can easily see
        # what's in one of the arrays
        my %lookup = map(
            { $_ => 1; }
            @{$ARG[0][$indices->[0]]}
        );
        my %seen = ();

        # Loop over the contents of the 'other' array
        foreach my $num (@{$ARG[0][$indices->[1]]}){
            # If this number isn't in the first array and
            # it hasn't been seen, store it
            push(@{$missing[$indices->[1]]}, $num)
                unless($lookup{$num} || $seen{$num});

            # Mark this number as seen
            $seen{$num} = 1;
        }
    }

    return(@missing);

}



