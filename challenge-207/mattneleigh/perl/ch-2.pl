#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @citations_lists = (
    # Given cases
    [ 10, 8, 5, 4, 3 ],
    [ 25, 8, 5, 3, 3 ],

    # Additional test cases
    [ 9, 7, 6, 2, 1 ],
    [ 1, 1, 1, 1, 1, 1, 1 ]
);

print("\n");
foreach my $citations (@citations_lists){
    printf(
        "Input: \@citations = (%s)\nOutput: %d\n\n",
        join(", ", @{$citations}),
        calculate_h_index(@{$citations})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################


################################################################################
# Calculate the h-index for a list of citation counts; see
# https://en.wikipedia.org/wiki/H-index for more details about the significance
# of this number
# Takes one argument:
# * A list of citation counts, one per paper or journal article
# Returns:
# * The h-index of the collection of papers described by the citation count
#   list
################################################################################
sub calculate_h_index{

    my $h_index = 1;

    # Sort the argument list in descending
    # order
    @ARG = sort({ $b <=> $a } @ARG);

    # Loop while $h_index is less than or equal
    # to the current most-cited paper; this will
    # overshoot by one in all cases
    while($h_index <= $ARG[0]){
        # Increment the h-index and remove the most-
        # cited paper from the list
        $h_index++;
        shift(@ARG);
    }

    # Decrement and return
    return(--$h_index);

}



