#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @sets = (
    [ [ 4, 5, 1, 6 ], 2 ],
    [ [ 1, 2, 3, 4 ], 2 ],
    [ [ 1, 3, 4, 5 ], 3 ],
    [ [ 5, 1, 2, 3 ], 4 ],
    [ [ 7, 2, 4, 5 ], 4 ]
);

print("\n");
foreach my $set (@sets){

    printf(
        "Input: \@list = (%s), \$k = %d\nOutput: %d\n\n",
        join(", ", @{$set->[0]}),
        $set->[1],
        count_divisible_pairs($set->[0], $set->[1])
    );

}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers and a value k, finds the number of pairs (i, j) in
# the list that satisfy the following conditions:
#   1) 0 <= i < j < len(list)
#   2) list[i] + list[j] is divisible by k
# Takes two arguments:
# * A ref to the list of integers; the contents of the list will not be
#   modified
# * The value k
# Returns:
# * The number of pairs that satisfy the conditions specified above
################################################################################
sub count_divisible_pairs{
    my $list = shift();
    my $k = shift();

    my $pairs = 0;

    # Loop over each possible pair of list elements
    for my $i (0 .. ($#$list - 1)){
        for my $j (($i + 1) .. $#$list){
            # Increment the pair count if $k divides evenly
            # into the sum
            $pairs++
                unless(($list->[$i] + $list->[$j]) % $k);
        }
    }

    return($pairs);

}



