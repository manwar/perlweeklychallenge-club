#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 1, 4, 3 ],
    [ 2, 4, 1, 3 ],
    [ 1, 3, 2, 4, 5 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        swaps_to_semi_ordered_list(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a contiguous (though not necessarily consecutive) list of integers from
# 1 to N where N is the number of integers in the list, determine how many
# swaps it would take to move 1 and N to the 1st and Nth positions in the list,
# respectively, given that swaps can only take place between adjacent members
# of the list
# Takes one argument:
# * The contiguous (though not necessarily consecutive) list of integers from 1
#   to N where N is the number of integers in the list (e.g. ( 2, 4, 1, 3 ) )
# Returns:
# * The number of swaps required to move 1 and N to the 1st and Nth positions
#   in the list, respectively (e.g. 3 ); if no swaps are required, 0 will be
#   returned
################################################################################
sub swaps_to_semi_ordered_list{

    my $min_loc;
    my $max_loc;

    # Find the locations of the min (1)
    # and max (scalar(@ARG) values
    foreach my $i (0 .. $#ARG){
        $min_loc = $i
            if($ARG[$i] == 1);
        $max_loc = $i
            if($ARG[$i] == scalar(@ARG));
    }

    return(
        # Distance the min value had to move
        $min_loc
        +
        # Distance the max value had to move
        ($#ARG - $max_loc)
        -
        # Subtract one if the min and max had
        # to cross over each other (their swap
        # would count twice otherwise)
        (
            $max_loc < $min_loc ?
                1
                :
                0
        )
    );

}



