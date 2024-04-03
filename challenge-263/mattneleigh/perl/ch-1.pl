#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [
        [ 1, 5, 3, 2, 4, 2 ],
        2
    ],
    [
        [ 1, 2, 4, 3, 5 ],
        6
    ],
    [
        [ 5, 3, 2, 4, 2, 1 ],
        4
    ]
);

print("\n");
foreach my $data_set (@data_sets){
    printf(
        "Input: \@ints = (%s), \$k = %d\nOutput: (%s)\n\n",
        join(", ", @{$data_set->[0]}),
        $data_set->[1],
        join(", ", find_matching_sorted_indices($data_set))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine at which indices in a sorted array a given value is found; the
# array need not be sorted when presented for analysis
# Takes one argument:
# * A ref to a data structure that contains the array and the target value
#   (e.g.
#       [
#           # Array to examine
#           [ 1, 5, 3, 2, 4, 2 ],
#
#           # Target value
#           2
#       ]
#   )
# Returns:
# * A list of locations at which the target value appeared in a sorted version
#   of the array (e.g. ( 1, 2 ) ).  If the target value is not found, an empty
#   list is returned.
################################################################################
sub find_matching_sorted_indices{

    # Start indices at -1 since we need to
    # increment before returning the value
    # later
    my $i = -1;

    return(
        map(
            {
                # Pre-increment
                $i++;

                # Evaluate as the index if the value
                # matches our target, or the empty
                # list if it doesn't
                $ARG[0][1] == $_ ?
                    $i
                    :
                    ();
            }
            sort(@{$ARG[0][0]})
        )
    );

}



