#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 3, 2, 3, 1 ],
    [ 2, 4, 3, 5, 1 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@nums = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        count_reverse_pairs(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine how many reverse pairs are in a list of integers, where a reverse
# pair is defined as any ($i, $j) within the list where:
#
#   1) 0 <= $i < $j <= $#ints
#   2) $ints[$i] > 2 * $ints[$j].
#
# Takes one argument:
# * A list of integers to examine
# Returns:
# * The count of reverse pairs found within the list, where reverse pairs are
#   defined above
################################################################################
sub count_reverse_pairs{

    my $count = 0;

    # Loop over every pair within the list
    for my $i (0 .. $#ARG - 1){
        for my $j ($i .. $#ARG){
            # Increment the count if this pair meets
            # the specified criteria
            $count++
                if($ARG[$i] > 2 * $ARG[$j]);
        }
    }

    return($count);

}



