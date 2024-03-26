#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [
        [ 3, 1, 2, 2, 2, 1, 3 ],
        2
    ],
    [
        [ 1, 2, 3 ],
        1
    ]
);

print("\n");
foreach my $data_set (@data_sets){
    printf(
        "Input: \@ints = (%s) and \$k = %d\nOutput: %d\n\n",
        join(", ", @{$data_set->[0]}),
        $data_set->[1],
        count_equal_pairs_with_divisible_index_products($data_set)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers @ints and an integer divisor $k, count the pairs
# $i and $j within the array that satisfy the following conditions:
#
# * 0 <= $i < $j <= $#ints
# * $ints[$i] == $ints[$j]
# * ($i * $j) % $k == 0  (product of $i and $j is divisible by $k)
#
# Takes one argument:
# * A ref to a data structure that contains a list of integers, and an integer
#   divisor (e.g.
#       [
#           # The array of ints
#           [ 3, 1, 2, 2, 2, 1, 3 ],
#           # The divisor
#           2
#       ]
#   )
# Returns:
# * The count of pairs within the integer list that are equal and whose indices
#   have a product that is evenly divisible by the divisor
################################################################################
sub count_equal_pairs_with_divisible_index_products{
    use integer;

    my $ints = $ARG[0][0];
    my $k = $ARG[0][1];
    my $i;
    my $j;
    my $pairs = 0;

    # Loop over all pairs within the
    # interger list
    for $i (0 .. $#$ints - 1){
        for $j ($i + 1 .. $#$ints){
            # Increment the count if the values at
            # $i and $j are qual and the product of
            # $i and $j can be divided evenly by $k
            $pairs++
                if(
                    ($ints->[$i] == $ints->[$j])
                    &&
                    !(($i * $j) % $k)
                );
        }
    }

    return($pairs);

}



