#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @things = (
    [
        [ 2, 5, 9, 11, 3 ],
        1
    ],
    [
        [ 2, 5, 9, 11, 3 ],
        2
    ],
    [
        [ 2, 5, 9, 11, 3 ],
        0
    ]
);

print("\n");
foreach my $thing (@things){
    printf(
        "Input: \@ints = (%s)\n       \$k = %d\nOutput: %d\n\n",
        join(", ", @{$thing->[0]}),
        $thing->[1],
        sum_elements_with_particularly_positive_indices(
            $thing->[1],
            @{$thing->[0]}
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, sum the elements whose indices within the array
# have a specific number of ones in their binary representation
# Takes two arguments:
# * The desired number of ones in array indices (e.g. 1 )
# * An array of integers (e.g. ( 2, 5, 9, 11, 3 ) )
# Returns:
# * The sum of the integers from the array whose indices have the desired
#   quantity of ones (e.g. 17 (which is 5 + 9 + 3))
################################################################################
sub sum_elements_with_particularly_positive_indices{
    my $desired_ones = shift();

    my $index_value;
    my $ones;
    my $sum = 0;

    for my $index (0 .. $#ARG){
        $index_value = $index;
        $ones = 0;

        # Count the number of ones in this index value
        while($index_value){
            $ones++
                if($index_value & 0x01);
            $index_value >>= 1;
        } 

        # If this index had the number of ones we're
        # looking for, add the array value at this
        # index to the sum
        $sum += $ARG[$index]
            if($ones == $desired_ones);
    }

    return($sum);

}



