#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 10, 4, 20, 1, 3, 2 ],
    [ 0, 6, 1, 8, 5, 2, 4, 3, 0, 7 ],
    [ 10, 30, 20 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        longest_consecutive_sequence(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of unsorted integers, determine the longest sequence of
# consecutive elements therein; this operation will take O(n) time
# Takes one argument:
# * The list of integers to examine (e.g. ( 10, 4, 20, 1, 3, 2 ) )
# Returns:
# * The length of the longest sequence of consecutive elements, which must be
#   at least 2 (e.g. 4, as in the example above)
# * -1 if no sequence of consecutive elements is present in the list
################################################################################
sub longest_consecutive_sequence{

    # Build a table of values present in the
    # list
    my %table = map(
        { $_ => 1 }
        @ARG
    );
    my $curr_sequence;
    my $max_sequence = 0;

    foreach my $int (keys(%table)){
        # Skip ahead if this is NOT the start of a
        # consecutive sequence
        next
            if($table{$int - 1});

        # Advance one value, and loop while we have
        # consecutive values, counting along the way
        $int++;
        $curr_sequence = 1;
        while($table{$int++}){
            $curr_sequence++;
        }

        # If this sequence is the largest yet seen,
        # store its length
        $max_sequence = $curr_sequence
            if($curr_sequence > $max_sequence);
    }

    # If we have a sequence longer than 1,
    # return it; otherwise return -1
    return(
        $max_sequence > 1 ?
            $max_sequence
            :
            -1
    );

}



