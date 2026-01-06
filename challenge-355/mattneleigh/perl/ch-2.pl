#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 2, 3, 4, 5 ],
    [ 0, 2, 4, 6, 4, 2, 0 ],
    [ 5, 4, 3, 2, 1 ],
    [ 1, 3, 5, 5, 4, 2 ],
    [ 1, 3, 2 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %s\n\n",
        join(", ", @{$integer_list}),
        is_mountain_array(@{$integer_list}) ?
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
# Determine whether an array of at least three (3) integers is a Mountain
# Array- that is to say, one in which, for 0 < $i < $#arr within the array,
# there is one $i such that:
# $arr[0] < $arr[1] < ... < $arr[$i - 1] < $arr[$i]
# $arr[$i] > $arr[$i + 1] > ... > $arr[$#arr]
# Takes one argument:
# * The array of integers to examine (e.g. (0, 2, 4, 6, 4, 2, 0) )
# Returns
# * 1 if the array is a Mountain Array (as it would be given the example above)
#   and 0 if it is not or does not have at least three elements
################################################################################
sub is_mountain_array{
    my @ints = @ARG;

    # Make sure we have enough integers, and handle the
    # edge cases
    return(0)
        unless(
            (@ints >= 3)
            &&
            ($ints[0] < $ints[1])
            &&
            ($ints[-2] > $ints[-1])
        );

    my $ascending = 1;

    # Loop over the remaining indices...
    for my $i (2 .. $#ints - 1){
        if($ascending){
            # If we're ascending, see if the current pair is
            # still ascendant
            unless($ints[$i - 1] < $ints[$i]){
                # If not, this array is not a mountain array if
                # members of the pair are equal; otherwise
                # switch to descending mode
                return(0)
                    if($ints[$i - 1] == $ints[$i]);
                $ascending = 0;
            }
        } else{
            # If we're descending, make sure the current pair
            # is still descendant
            return(0)
                if($ints[$i] < $ints[$i + 1]);
        }
    }

    # Got here- must be a mountain array
    return(1);

}



