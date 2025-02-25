#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 4, 14, 2 ],
    [ 4, 14, 4 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        calculate_hamming_distance_sum(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of positive integers, calculate the sum of the Hamming Distance
# between each pair within the list, where the Hamming Distance is the number
# of corresponding bits in the binary representations of each that have
# different values
# Takes one argument:
# * The list of positive integers to examine (e.g. ( 4, 14, 2 ) )
# Returns:
# * The sum of the Hamming Distance between each pair within the list (e.g. 6 )
################################################################################
sub calculate_hamming_distance_sum{

    my $sum = 0;
    my $xored_int;
    my $hamming_distance;

    # Loop over every pair of integers in the list
    for my $i (0 .. $#ARG - 1){
        for my $j ($i + 1 .. $#ARG){
            $hamming_distance = 0;

            # XOR the two ints, leaving ones only where
            # the two ints' binary representations differ
            $xored_int = $ARG[$i] ^ $ARG[$j];

            # Count the ones in the XOR'd value
            while($xored_int){
                $hamming_distance++
                    if($xored_int & 0x01);
                $xored_int >>= 1;
            }

            # Add this count of ones to the sum
            $sum += $hamming_distance;
        }
    }

    return($sum);

}



