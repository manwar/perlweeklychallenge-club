#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 4, 2, -1, 3, -2 ],
    [ -5, 5, -3, 3, -1, 1 ],
    [ 7, -3, 0, 2, -8 ],
    [ -2, -5, -1, -8 ],
    [ -2, 2, -4, 4, -1, 1 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@nums = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        min_distance_to_zero(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers, determine the closest value to zero among them
# Takes one argument:
# * A list of intetgers to examine (e.g. (-5, 5, -3, 3, -1, 1) )
# Returns:
# * The minimum distance from zero among the values in the supplied list (e.g.
#   1)
################################################################################
sub min_distance_to_zero{
    use List::Util qw(min);

    return(
        # 2. Determine which absolute value is smallest
        min(
            # 1. Get the absolute values of all the supplied
            # integers
            map(
                abs($_),
                @ARG
            )
        )
    );

}



