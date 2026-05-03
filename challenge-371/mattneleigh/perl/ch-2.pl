#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @number_lists = (
    [  2,  1,  4,  3 ],
    [  3,  0,  3,  0 ],
    [  5,  1,  1,  1 ],
    [  3, -1,  4,  2 ],
    [ 10, 20, 30, 40 ]
);

print("\n");
foreach my $number_list (@number_lists){
    printf(
        "Input: \@nums = (%s)\nOutput: %s\n\n",
        join(", ", @{$number_list}),
        join(
            ", ",
            map(
                # Reject any single-member subsets
                scalar(@{$_}) > 1 ? "(" . join(", ", @{$_}) . ")" : (),
                subset_index_sum(@{$number_list})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, find all proper subsets in which the sum of the
# elements in the subset is equal to the sum of their 1-indexed positions
# within the original array; note that values need not be positive
# Takes one argument:
# * The array to examine (e.g. ( 3, 0, 3, 0 ) )
# Returns:
# * A list of subsets whose elements' sum equals the sum of their 1-indexed
#   positions within the original array (e.g.
#       (
#           [ 3, 0 ],
#           [ 3 ],
#           [ 3, 0, 3 ]
#       )
#   ) or an empty list if no such subsets were found
################################################################################
sub subset_index_sum{

    my @subset_indices;
    my @subsets;
    my $bits = 0;
    my $max = 2 ** scalar(@ARG) - 2;
    my $index_sum;
    my $value_sum;

    # Loop over all values that can be
    # represented with N bits, where N is the
    # number of arguments- except 0 and the
    # maximum value, in the latter case to ensure
    # we only look for Proper Subsets
    while($bits++ < $max){
        @subset_indices = ();
        $index_sum = 0;
        $value_sum = 0;

        # If the bit for this argument is 1, add to
        # the sums and store its index
        for my $index (0 .. $#ARG){
            if($bits & (1 << $index)){
                $index_sum += $index + 1;
                $value_sum += $ARG[$index];
                push(@subset_indices, $index);
            }
        }

        # If the sum of the one-indexed positions
        # matches the sum of the values at those
        # positions, store the values of this subset
        push(@subsets, [ @ARG[@subset_indices] ])
            if($index_sum == $value_sum);
    }

    return(@subsets);

}



