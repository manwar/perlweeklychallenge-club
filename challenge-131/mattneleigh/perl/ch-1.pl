#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    [ 1, 2, 3, 6, 7, 8, 9 ],
    [ 11, 12, 14, 17, 18, 19 ],
    [ 2, 4, 6, 8 ],
    [ 1, 2, 3, 4, 5 ]
);
my $list;

foreach $list (@lists){
    printf("Input: (%s)\n", join(", ", @{$list}));
    printf(
        "Output: (%s)\n\n",
        join(
            ", ",
            map(
                { sprintf("[%s]", join(", ", @{$_})) }
                find_consecutive_integers(@{$list})
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find consecutive integers within a list
# Takes one argument:
# * A list of integers, which must be unique and sorted in ascending order
# Returns:
# * A list of array refs, each containing a block of consecutive integers; if
#   no consecutive integers are found, each array will have just one member
# Examples:
#
# Given the list:
#   (11, 12, 14, 17, 18, 19)
# Returns:
#   ([11, 12], [14], [17, 18, 19])
#
# Given the list:
#   (2, 4, 6, 8)
# Returns:
#   ([2], [4], [6], [8])
#
################################################################################
sub find_consecutive_integers{

    my @arrays = ();

    # Initialize the current array
    # with the first argument
    my $array = [ shift() ];

    # Loop over remaining args
    foreach(@ARG){
        unless($_ == $array->[$#$array] + 1){
            # Next arg is not consecutive-
            # store the current array in the
            # return list and start a new one
            push(@arrays, $array);
            $array = [];
        }
        # Add the next arg to the current
        # array
        push(@{$array}, $_);
    }

    # Store the last array in the
    # return list
    push(@arrays, $array);

    return(@arrays);

}



