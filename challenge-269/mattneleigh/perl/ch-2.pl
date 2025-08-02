#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 1, 3, 4, 5 ],
    [ 3, 2, 4 ],
    [ 5, 4, 3 ,8 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", redistribute_and_concatenate(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Redistribute the contents of an array accordint to the following rules:
# 1) Place the first element from the given array to a new array, @arr1
# 2) Place the second element from the given array to a new array, @arr2
# 3) If the last element of @arr1 is greater than the last element of @arr2,
#    place the next element of the given array into @array1
#    - or -
#    place the next element of the given array into @array2
# 4) If there are elements remaining in the given array, return to Rule 3
# 5) Concatenate @arr1 and @arr2, and return the result
# Takes one argument:
# * The list of integers to process (e.g. ( 2, 1, 3, 4, 5 ) )
# Returns:
# * A copy of the list, redistributed as described above (e.g.
#   ( 2, 3, 4, 5, 1 ) )
################################################################################
sub redistribute_and_concatenate{

    # Grab the first and second element of the
    # given array and store them in the new
    # arrays
    my @arr1 = (shift());
    my @arr2 = (shift());

    # Loop while we have elements left in the
    # given array
    while(@ARG){
        # Compare trailing array elements from each
        # new array
        if($arr1[$#arr1] > $arr2[$#arr2]){
            # Add the next element from the given array
            # to array 1
            push(@arr1, shift());
        } else{
            # Add the next element from the given array
            # to array 2
            push(@arr2, shift());
        }
    }

    # Concatenate new arrays and return
    return(@arr1, @arr2);

}



