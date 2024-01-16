#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 3, 2, 3, 2, 2, 2 ],
    [ 1, 2, 3, 4 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    my @pairs = find_equal_pairs(@{$integer_list});

    printf(
        "Input: \@ints = (%s)\nOutput: %s\n\n",
        join(", ", @{$integer_list}),
        scalar(@pairs) ?
            join(
                ", ",
                map(
                    "(" . join(", ", @{$_}) . ")",
                    @pairs
                )
            )
            :
            "()"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers with an even number of elements, divide it into
# pairs of equal numbers
# Takes one argument:
# * A list of integers with an even number of elements (e.g.
#   ( 3, 2, 3, 2, 2, 2 ) )
# Returns on success:
# * A list of equal pairs from within the original list (e.g.
#       (
#           [ 2, 2 ],
#           [ 2, 2 ],
#           [ 3, 3 ]
#       )
#   )
# Returns on error:
# * The empty list (i.e. () ) if there were an odd number of integers ni the
#   list or an unequal pair was encountered
################################################################################
sub find_equal_pairs{

    # Can't make pairs if there aren't an even
    # number of integers
    return( () )
        if(scalar(@ARG) % 2);

    my @pairs;

    # Sort the ints to make pair matching
    # easier
    @ARG = sort({ $a <=> $b } @ARG);

    # Loop over the integers while we still
    # have them
    while(@ARG){
        # Can't make equal pairs if a pair is
        # unequal
        return( () )
            unless($ARG[0] == $ARG[1]);

        # Remove the first pair from the list and
        # store it; doing this with two shift()s
        # is a little faster than one splice()
        push(@pairs, [ shift(@ARG), shift(@ARG) ]);
    }

    return(@pairs);

}



