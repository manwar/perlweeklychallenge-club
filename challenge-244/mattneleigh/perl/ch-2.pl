#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 1, 4 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@nums = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        calculate_combination_power_sum(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the sum of the powers of all possible combinations of a list of
# integers, with the power being defined as the square of the largest number
# in a sequence, multiplied by the smallest in the sequence
# Takes one argument:
# * A list of integers (e.g. (2, 1, 4) )
# Returns: 
# * The sum of all powers of all possible combinations (see definition above)
#   within the list (e.g. 141)
################################################################################
sub calculate_combination_power_sum{
    use List::Util qw(min max);

    my $sum = 0;

    # Loop over every possible combination of
    # integers
    for my $combination (combinations(@ARG)){
        # Skip the empty list that combinations() can
        # return (see its documentation)
        next
            unless(scalar(@{$combination}));

        # Add to the sum the square of the max value
        # in this combination list multiplied by the
        # minimum value in the list
        $sum += (max(@{$combination}) ** 2) * min(@{$combination});
    }

    return($sum);

}



################################################################################
# Given a list of N integers, provides a list of all possible combinations of
# M integers, for all M where 0 <= M <= N
# Takes one argument:
# * A list of integers (e.g. (2, 1, 4) )
# Returns:
# * A list of all possible combinations of M integers, including where M equals
#   zero (e.g.
#       (
#           [ ],
#           [ 2 ],
#           [ 1 ],
#           [ 2, 1 ],
#           [ 4 ],
#           [ 2, 4 ],
#           [ 1, 4 ],
#           [ 2, 1, 4 ]
#       )
#   )
#
# NOTE: Translated and adapted from a Python solution found in the comments at:
# https://stackoverflow.com/questions/464864/get-all-possible-2n-combinations-of-a-list-s-elements-of-any-length
################################################################################
sub combinations{

    return([])
        unless(scalar(@ARG));

    my @cs;

    for my $c (combinations(@ARG[1 .. $#ARG])){
        push(@cs, [ @{$c} ], [ $ARG[0], @{$c} ]);
    }

    return(@cs);

}



