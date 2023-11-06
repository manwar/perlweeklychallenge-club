#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @matrices = (
    [
        [ 1, 1, 0 ],
        [ 1, 0, 1 ],
        [ 0, 0, 0 ]
    ],
    [
        [ 1, 1, 0, 0 ],
        [ 1, 0, 0, 1 ],
        [ 0, 1, 1, 1 ],
        [ 1, 0, 1, 0 ]
    ]
);

print("\n");
foreach my $matrix (@matrices){
    printf(
        "Input: \@matrix = (%s)\nOutput: (%s)\n\n",
        join(
            ", ",
            map(
                "[" . join(", ", @{$_}) . "]",
                @{$matrix} 
            )
        ),
        join(
            ", ",
            map(
                "[" . join(", ", @{$_}) . "]",
                @{flip_binary_matrix($matrix)}
            )
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Flip a binary matrix (made of ones and zeros only) according to the following
# procedure:
#   1) Invert each member of the matrix, changing 0 to 1 and vice-versa
#   2) Reverse the order of members within each row of the matrix
# Takes one argument:
# * A ref to an array of arrays the represents the matrix (e.g.
#       [
#           [ 1, 1, 0 ],
#           [ 1, 0, 1 ],
#           [ 0, 0, 0 ]
#       ]
#   )
# Returns:
# * A ref to a flipped copy of the matrix (e.g.
#       [
#           [ 1, 0, 0 ],
#           [ 0, 1, 0 ],
#           [ 1, 1, 1 ]
#       ]
#   )
################################################################################
sub flip_binary_matrix{

    return(
        # 4: Get a ref to the matrix we've made
        [
            # 3: Combine all new rows into a new matrix
            # array
            map(
                [
                    # 2: Reverse the order of members within the
                    # row
                    reverse(
                        # 1: Make a copy of each row with the members
                        # inverted
                        map(
                            $_ ? 0 : 1,
                            @{$_}
                        )
                    )
                ],
                @{$ARG[0]}
            )
        ]
    );

}



