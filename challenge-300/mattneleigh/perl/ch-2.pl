#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 5, 4, 0, 3, 1, 6, 2 ],
    [ 0, 1, 2 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        longest_unique_set(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers of length N containing a permutation of numbers in
# the range (0 .. N - 1), find the length of the longest set I such that
# set[I] = (ints[I], ints[ints[I]], ints[ints[ints[I]]] ... ) and the set
# follows this rule only so far as is possible without introducing a duplicate
# value from the list
# Takes one argument:
# * The list of integers to examine (e.g ( 5, 4, 0, 3, 1, 6, 2 ) )
# Returns:
# * The length of the longest set that meets the criteria above (e.g. 4, as one
#   of the sets that qualifies is ( 5, 6, 2, 0 ) )
################################################################################
sub longest_unique_set{

    my $max_length = 0;

    # Loop over all indices and start building a
    # set at each
    foreach my $i (0 .. $#ARG){
        # Initialize the set with its first value and
        # mark it as seen
        my @set = ( $ARG[$i] );
        my %seen = ( $set[0] => 1 );

        # Follow subsequent values in the integer
        # list until we run into a duplicate
        while(!$seen{$ARG[$set[-1]]}){
            # Mark the next value as seen and add it to
            # the set
            $seen{$ARG[$set[-1]]} = 1;
            push(@set, $ARG[$set[-1]]);
        }

        # If this is the longest set seen so far,
        # make a note of its length
        $max_length = scalar(@set)
            if(scalar(@set) > $max_length);
    }

    return($max_length);

}



