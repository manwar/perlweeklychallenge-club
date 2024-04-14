#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ordered_pair_sets = (
    [
        [ 0, 1, 2, 3, 4 ],
        [ 0, 1, 2, 2, 1 ]
    ],
    [
        [ 1, 2, 3, 4, 0 ],
        [ 0, 1, 2, 3, 0 ]
    ],
    [
        [ 1 ],
        [ 0 ]
    ]
);

print("\n");
foreach my $ordered_pair_set (@ordered_pair_sets){
    printf(
        "Input: \@source  = (%s)\n"
        .
        "       \@indices = (%s)\n"
        .
        "Output: (%s)\n\n",
        join(", ", @{$ordered_pair_set->[0]}),
        join(", ", @{$ordered_pair_set->[1]}),
        join(", ", create_ordered_array($ordered_pair_set))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Create an array based on particular numbers and a set of indices that
# indicate where the numbers should be inserted into said array
# Takes one argument:
# * A ref to a pair of parallel arrays containing numbers to insert into the
#   target array, and the indices at which these numbers must be inserted (e.g.
#       [
#           [ 0, 1, 2, 3, 4 ],
#           [ 0, 1, 2, 2, 1 ]
#       ]
#   )
# Returns:
# * The constructed list based on the supplied index/number pairs (e.g.
#   ( 0, 4, 1, 3, 2 ) )
################################################################################
sub create_ordered_array{

    my @target;

    # Loop over the supplied index/number
    # pairs
    for my $i (0 .. $#{$ARG[0][0]}){
        if($ARG[0][1][$i] > $#target){
            # The given index is outside the array-
            # append the number to the end
            push(@target, $ARG[0][0][$i]);
        } else{
            # The given index is within the array-
            # insert the number ahead of the value
            # currently at that location
            splice(
                @target,
                $ARG[0][1][$i],
                1,
                ($ARG[0][0][$i], $target[$ARG[0][1][$i]])
            );
        }
    }

    return(@target);

}



