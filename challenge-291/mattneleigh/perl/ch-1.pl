#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 3, -1, 8, 4 ],
    [ 1, -1, 4 ],
    [ 2, 5 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        find_middle_index(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find the Middle Index of a list of integers- that is to say, the index at
# which the sum of the elements to the left of that position is equal to the
# sum of those to the right (i.e.
# sum(@list[0 .. $MI-1]) == sum(@list[$MI+1 .. $#list]) ).  Note that the value
# at the Middle Index itself is NOT taken into account.  If more than one
# Middle Index exists, the leftmost (first) is returned.
# Takes one argument:
# * The list of integers to examine (e.g. ( 2, 3, -1, 8, 4 ) )
# Returns on success:
# * The Middle Index from the list (e.g. 3 )
# Returns on failure:
# * -1 if the list does not have a Middle Index
################################################################################
sub find_middle_index{

    my $i;
    my $left_sum = 0;
    my $right_sum = 0;

    # Tally up all the values in the list AFTER the
    # first, forming the right sum
    for $i (1 .. $#ARG){
        $right_sum += $ARG[$i];
    }

    # Loop over all indices within the list
    $i = 0;
    while(1){
        # If the left sum and the right sum are equal,
        # this is a Middle Index; return it
        return($i)
            if($left_sum == $right_sum);

        # We just evaluated the last element; if we
        # didn't return already, no Middle Index was
        # found
        return(-1)
            if($i == $#ARG);

        # Add the current value to the left sum,
        # increment the index, then subtract the new
        # current value from the right sum
        $left_sum += $ARG[$i++];
        $right_sum -= $ARG[$i];
    }

}



