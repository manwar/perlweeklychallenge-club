#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @letter_sets = (
    [
        [ 'R', 'E', 'P', 'L' ],
        [ 3, 2, 1, 4 ]
    ],
    [
        [ 'A', 'U', 'R', 'K' ],
        [ 2, 4, 1, 3 ]
    ],
    [
        [ 'O', 'H', 'Y', 'N', 'P', 'T' ],
        [ 5, 4, 2, 6, 1, 3 ]
    ]
);

print("\n");
foreach my $letter_set (@letter_sets){
    printf(
        "Input: \@letters = (%s)\n\@weights = (%s)\nOutput: %s\n\n",
        join(
            ", ",
            map(
                "'" . $_ . "'",
                @{$letter_set->[0]}
            )
        ),
        join(
            ", ",
            @{$letter_set->[1]}
        ),
        combine_letters_by_weight($letter_set)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a set of letters and relative numerical weights, combine the letters
# into a single word, ordered by the specified weights
# Takes one argument:
# * A ref to an array that contains two parallel arrays- one of letters, and
#   one of relative weights (e.g.
#       [
#           [ 'R', 'E', 'P', 'L' ],
#           [  3,   2,   1,   4  ]
#       ]
#   )
# Returns:
# * A word made up of the letters sorted by the specified weights (e.g. "PERL")
################################################################################
sub combine_letters_by_weight{

    return(
        # 4: Join the letters into a single word
        join(
            "",
            # 3: Extract a list of just the sorted letters
            map(
                $_->[0],
                # 2: Sort the list in ascending order by weight
                sort(
                    { $a->[1] <=> $b->[1] }
                    # 1: Make a list of of letters and their specified
                    # weights (e.g. [ "R", 3 ] )
                    map(
                        [ $ARG[0][0][$_], $ARG[0][1][$_] ],
                        0 .. $#{$ARG[0][0]}
                    )
                )
            )
        )
    );

}



