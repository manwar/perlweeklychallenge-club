#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @stick_length_lists = (
    [ 1, 2, 2, 2, 1 ],
    [ 2, 2, 2, 4 ],
    [ 2, 2, 2, 2, 4 ],
    [ 3, 4, 1, 4, 3, 1 ]
);

print("\n");
foreach my $stick_lengths (@stick_length_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %s\n\n",
        join(", ", @{$stick_lengths}),
        can_make_square(@{$stick_lengths}) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers representing the lengths of a collection of sticks,
# determine whether it is possible to arrange all of the sticks to form a
# square; note that no particular square-making arrangement, if any, is
# recorded or reported
# Takes one argument:
# * The list of stick lengths to examine (e.g. ( 3, 4, 1, 4, 3, 1 ) )
# Returns:
# * 0 if it is not possible to form a square with the given sticks
# * 1 if it is possible to form a square with the given sticks (as would be the
#   case in the example above)
################################################################################
sub can_make_square{

    return(
        _square_recursor(
            [ @ARG ],
            [ 0, 0, 0, 0 ],
            0
        )
    );

}



################################################################################
# Recursively search for squares among the possible arrangements of sticks to
# determine whether a square can be formed with the current arrangement or any
# subsequently examined one; this function breaks off the search after the
# first square is found
# Takes three arguments:
# * A ref to the list of stick lengths (e.g. [ 3, 4, 1, 4, 3, 1 ] )
# * A ref to a list representing the total length of sticks currently assigned
#   to each side of the square (initially [ 0, 0, 0, 0 ] )
# * The index of the current stick to examine (initially 0)
# Returns:
# * 0 if it is not possible to form a square with the given sticks in the
#   current arrangement or any arrangement found subsequent to the specified
#   one
# * 1 if a square was found in the current arrangement or a subsequent one
# NOTE: This should only be called by can_make_square() with the correct
# initial arguments (see above)
################################################################################
sub _square_recursor{
    my ($sticks, $square, $stick) = @ARG;

    # Loop over all sides
    foreach my $side (0 .. 3){
        # Add this stick to this side
        $square->[$side] += $sticks->[$stick];

        if($stick == $#$sticks){
            # This is the last stick- return 1 if we
            # just made a square with it
            return(1)
                if(
                    $square->[0] == $square->[1]
                    &&
                    $square->[1] == $square->[2]
                    &&
                    $square->[2] == $square->[3]
                );
        } else{
            # Not the last stick- run a deeper iteration
            # on the next stick with the current stick
            # still in place, returning 1 if it found a
            # square
            return(1)
                if(_square_recursor($sticks, $square, $stick + 1));
        }

        # Subtract this stick from this side before
        # moving on to the next one
        $square->[$side] -= $sticks->[$stick];
    }

    # If we got here, neither this call nor any
    # deeper one was able to make a square
    return(0);

}



