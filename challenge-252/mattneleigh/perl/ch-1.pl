#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 2, 3, 4 ],
    [ 2, 7, 1, 19, 18, 3 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        sum_squares_special_elements(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers, calculate the sum of the squares of all Special
# Elements within the array, where Special Elements are those at positions in
# which their 1-indexed, er, index evenly divides into N where N is the number
# of elements in the list (i.e. I => (1 .. N) and N % I == 0 )
# Takes one argument:
# * The list of integers to examine (e.g. ( 2, 7, 1, 19, 18, 3 ) )
# Returns:
# * The sum of the suqares of the special elements, as defined above (e.g. 63 )
################################################################################
sub sum_squares_special_elements{

    my $sum = 0;

    # Loop from 1 to N + 1
    for my $i (1 .. $#ARG + 1){
        # Add the sum of the square of this value if
        # its adjusted index is Special
        $sum += $ARG[$i - 1] ** 2
            unless(scalar(@ARG) % $i);
    }

    return($sum);

}



