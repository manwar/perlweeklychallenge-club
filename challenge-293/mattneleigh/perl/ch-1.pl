#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @domino_sets = (
    # Given cases
    [ [1, 3], [3, 1], [2, 4], [6, 8] ],
    [ [1, 2], [2, 1], [1, 1], [1, 2], [2, 2] ],

    # Additional test cases
    [ [1, 2], [2, 1], [4, 6], [3, 4], [4, 3] ],
    [ [1, 2], [6, 3], [4, 2], [6, 6] ]
);

print("\n");
foreach my $domino_set (@domino_sets){
    my @similar_dominoes = find_similar_dominoes(@{$domino_set});
    my $similar_count = scalar(@similar_dominoes);

    printf(
        "Input: \@dominos = (%s)\nOutput: %d%s\n\n",
        join(
            ", ",
            map(
                "[" . join(", ", @{$_}) . "]",
                @{$domino_set}
            )
        ),
        $similar_count,
        $similar_count ?
            " ("
            .
            join(
                ", ",
                map(
                    "[" . join(", ", @{$_}) . "]",
                    @{$domino_set}[@similar_dominoes]
                )
            )
            .
            ")"
            :
            ""
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine which dominoes in a list are similar, where similar dominoes are
# defined as those that have the same values in the same positions, (e.g.
# [ 1, 3 ], [ 1, 3 ] ) or the same values in opposite positions (e.g. [ 1, 3 ],
# [ 3, 1 ] )
# Takes one argument:
# * A list of dominoes to examine (e.g. ( [1, 2], [2, 1], [1, 1], [1, 2],
#   [2, 2] )
# Returns
# * The indices of dominoes that are similar, as defined above (e.g. ( 0, 1,
#   3 ) )  If there are multiple groups of similar dominoes, these are not
#   differentiated; if there are no similar dominoes, an empty list is
#   returned.
################################################################################
sub find_similar_dominoes{

    my %similar_dominoes;

    # Loop over all possible pairs of dominoes
    for my $i (0 .. $#ARG - 1){
        for my $j ($i + 1 .. $#ARG){
            # Check for similarity, based on our
            # stated criteria...
            if(
                (
                    ($ARG[$i][0] == $ARG[$j][0])
                    &&
                    ($ARG[$i][1] == $ARG[$j][1])
                )
                ||
                (
                    ($ARG[$i][0] == $ARG[$j][1])
                    &&
                    ($ARG[$i][1] == $ARG[$j][0])
                )
            ){
                # ...and if the criteria are met, note the
                # indices at which the similar dominoes
                # were found
                $similar_dominoes{$i} = 1;
                $similar_dominoes{$j} = 1;
            }
        }
    }

    # Return the found indices, if any, sorted
    # in ascending order
    return(sort({ $a <=> $b } keys(%similar_dominoes)));

}



