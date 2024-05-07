#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 5, 3, 4 ],
    [ 9, 4, 1, 3, 6, 4, 6, 1 ],
    [ 1, 2, 2, 3 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", transposed_sort(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Rearrange a list of integers with an even number of elements such that it is
# sorted in ascending order, except that each apair within the list is
# transposed
# Takes one argument:
# * A list of integers with an even number of elements (e.g. ( 2, 5, 3, 4 ) )
# Returns:
# * A rearranged copy of the list (e.g. ( 3, 2, 5, 4 ) )
################################################################################
sub transposed_sort{
    my @ints = sort({ $a <=> $b } @ARG);

    my @rearranged;

    while(@ints){
        # Grab the first two remaining elements from the
        # sorted argument list, and add them to the
        # rearranged list in reversed order
        push(@rearranged, (splice(@ints, 0, 2))[1, 0]);
    }

    return(@rearranged);

}



