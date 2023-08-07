#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 3, 4, 2 ],
    [ 1, 2, 3 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@int = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        count_steps_required_for_array_reduction(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Count the steps required to reduce an array of unique integers to an empty
# list by applying the following rules:
# 1) If the first element is the smallest in the array, remove it from the
#    array
# 2) If the first element is NOT the smallest, move it to the end of the array
# Takes one argument:
# * The array to examine (e.g. (3, 4, 2) )
# Returns:
# * The number of steps required to process the array as described above (e.g.
#   5 )
################################################################################
sub count_steps_required_for_array_reduction{

    # Get a copy of @ARG, sorted in ascending
    # order
    my @mins = sort(@ARG);
    my $ops = 0;

    # Loop while there are still numbers
    # in @ARG
    while(@ARG){
        # Examine the first value in @ARG
        if($ARG[0] == $mins[0]){
            # A minimum value- discard it, and the
            # corresponding minimum
            shift(@ARG);
            shift(@mins);
        } else{
            # Not a minimum value- move it to the
            # end of @ARG
            push(@ARG, shift(@ARG));
        }
        $ops++;
    }

    return($ops);

}



