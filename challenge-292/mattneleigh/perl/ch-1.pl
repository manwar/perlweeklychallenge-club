#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_list = (
    [ 2, 4, 1, 0 ],
    [ 1, 2, 3, 4 ]
);

print("\n");
foreach my $integer_list (@integer_list){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        largest_is_double(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine whether the maximum value in a list of integers is twice as large
# as the second-largest value, and if so, report its location within the list
# Takes one argument:
# * The list of integers to examine (e.g. ( 2, 4, 1, 0 ) )
# Returns:
# * The index of the maximum value in the list if it's twice as large as the
#   second largest value (e.g. 1 )
# * -1 if the maximum value is NOT twice as large as the second-largest value
################################################################################
sub largest_is_double{

    my $max = $ARG[0];
    my $max_index = 0;
    my $second_max = $max;

    # We've already stored the value at index 0,
    # so scan the rest of the list for larger
    # values
    foreach my $index (1 .. $#ARG){
        if($ARG[$index] > $max){
            $max_index = $index;
            $second_max = $max;
            $max = $ARG[$index];
        }
    }

    # Determine whether the max was twice or
    # more the value of the second-max
    return(
        $max >= (2 * $second_max) ?
            $max_index
            :
            -1
    );

}



