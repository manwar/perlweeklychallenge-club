#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 0, 2, 3, 0, 4, 5, 0 ],
    [ 1, 2, 3 ],
    [ 1, 2, 3, 0 ],
    [ 0, 0, 1, 2 ],
    [ 1, 2, 0, 3, 4 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", zero_shift(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, duplicate each occurrence of zero (0), shifting
# the remaining elements to the right; the original length of the array is
# preserved, thus any elements shifted beyond said length are discarded.
# Takes one argument:
# * The array to examine (e.g. (1, 0, 2, 3, 0, 4, 5, 0) )
# Returns:
# * A copy of the array with elements manipulated as described above (e.g.
#   (1, 0, 0, 2, 3, 0, 0, 4) )
################################################################################
sub zero_shift{

    return(
        # 2) Use an array slice to extract just the elements
        # that lie within the confines of the original array
        (
            # 1) Make a copy of the array with zeros expanded
            map(
                $_ ? $_ : (0, 0),
                @ARG
            )
        )[0 .. $#ARG]
    );

}



