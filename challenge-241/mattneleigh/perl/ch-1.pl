#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_sets = (
    [
        [ 0, 1, 4, 6, 7, 10 ],
        3
    ],
    [
        [ 4, 5, 6, 7, 8, 9 ],
        2
    ]
);

print("\n");
foreach my $integer_set (@integer_sets){
    printf(
        "Input: \@nums = (%s)\n       \$diff = %d\nOutput: %d\n\n",
        join(", ", @{$integer_set->[0]}),
        $integer_set->[1],
        count_unique_arithmetic_triplets(
            $integer_set->[1],
            @{$integer_set->[0]}
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the number of unique Arithmetic Triplets in an array of integers,
# which must be sorted in ascending order; such Arithmetic Triplets will
# satisfy the following criteria:
# 
#   1) $i < $j < $k
#   2) $ints[$j] - $ints[$i] == $D
#   3) $ints[$k] - $ints[$j] == $D
#
# Takes two arguments:
# * A positive integer that represents a difference threshold D
# * A list of integers to examine, which must be sorted in ascending order
# Returns:
# * The number of unique arithmetic triplets observed in he list (see criteria
#   above)
################################################################################
sub count_unique_arithmetic_triplets{
    my $diff = shift();

    my $count = 0;

    # Loop over all $i, $j, $k within the bounds
    # of the array such that $i < $j < $k
    for my $i (0 .. $#ARG - 2){
        for my $j ($i + 1 .. $#ARG - 1){
            for my $k ($j + 1 .. $#ARG){
                # Add to the count if this set of $i, $j, $k
                # point to numbers that meet our criteria
                $count++
                    if(
                        ($ARG[$j] - $ARG[$i] == $diff)
                        &&
                        ($ARG[$k] - $ARG[$j] == $diff)
                    );
            }
        }
    }

    return($count);

}



