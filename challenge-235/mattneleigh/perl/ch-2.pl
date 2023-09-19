#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    # Given cases
    [ 1, 0, 2, 3, 0, 4, 5, 0 ],
    [ 1, 2, 3 ],
    [ 0, 3, 0, 4, 5 ],

    # Additional test case(s)
    [ 1, 2, 3, 4, 0 ],
    [ 1, 0, 3, 0, 5 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOuput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", duplicate_zeros_with_constant_length(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Duplicate zeros within an array of numbers, shifting all subsequent elements
# to the right, while preserving the original length of the array by deleting
# the rightmost element each time
# Takes one argument:
# * An array of numbers to examine (e.g. ( 1, 0, 2, 3, 0, 4, 5, 0 ) )
# Returns:
# * A copy of the array, modified as described above (e.g.
#   ( 1, 0, 0, 2, 3, 0, 0, 4 ) )
################################################################################
sub duplicate_zeros_with_constant_length{

    my $i = 0;

    # Loop over all @ARG except the last element;
    # any changes made there should be deleted
    # anyway
    while($i < $#ARG){
        unless($ARG[$i]){
            # This value is zero...
            # Get rid of the last element in the array
            pop(@ARG);

            # Replace the zero at $i with two zeros,
            # thus returning the array to its original
            # size, and increment $i en passant to skip
            # over the zero we just added
            splice(@ARG, $i++, 1, (0, 0));
        }

        # Move on to the next element
        $i++;
    }

    return(@ARG);

}



