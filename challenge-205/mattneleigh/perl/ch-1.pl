#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @arrays = (
    # Given cases
    [ 5, 3, 4 ],
    [ 5, 6 ],
    [ 5, 4, 4, 3 ],

    # Additional test cases
    [ 6, 4, 9, 8, 1, 3, 9, 2, 1 ],
    [ 5, 5, 5, 5, 5, 5, 5, 5, 4 ]
);

print("\n");
foreach my $array (@arrays){
    printf(
        "Input: \@array = (%s)\nOutput: %d\n\n",
        join(", ", @{$array}),
        third_largest_or_max(@{$array})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the third-largest unique value in an array of numbers
# Takes one argument:
# * The array to examine
# Returns:
# * The third-largest unique value in the array if there are at least three
#   unique values
# - OR -
# * The maximum value in the array if there are not at least three unique
#   values
################################################################################
sub third_largest_or_max{

    my $i = 0;

    # Sort the array in descending order
    @ARG = sort({ $b <=> $a } @ARG);

    # Loop over the array and trim duplicate
    # values
    while($i < $#ARG){
        if($ARG[$i] == $ARG[$i + 1]){
            # The current element and the next are
            # equal- delete the current element
            splice(@ARG, $i, 1);
        } else{
            # The current element and the next are not
            # equal- move on to the next one 
            $i++;
        }
    }

    # If the sorted and trimmed array has at least
    # three elements (max index greater than 1)
    # then return the third-largest value (index 2)
    # otherwise return the max value (index 0)
    return(
        $ARG[
            $#ARG > 1 ? 2 : 0
        ]
    );

}



