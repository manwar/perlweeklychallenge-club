#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integers = (
    # Given cases
    5, 3, 1,

    # Additional test cases
    4, 0
);

print("\n");
foreach my $integer (@integers){
    printf(
        "Input: \$n = %d\nOutput: (%s)\n\n",
        $integer,
        join(", ", create_zero_sum_array($integer))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a positive integer $n, return an array of $n unique integers that all
# add up to zero
# Takes one argument:
# * A positive integer $n (e.g. 4)
# Returns:
# * A list of $n integers that all add up to zero (e.g. ( -1, -2, 2, 1 ) )
################################################################################
sub create_zero_sum_array{
    my $count = shift();

    my @ints = ();

    # See if we have an odd number to deal with, and
    # if so, add a zero to the list, then decrement
    # the count
    if($count % 2){
        push(@ints, 0);
        $count--;
    }

    # Divide the count by two (it will be even now)
    # then loop until it's decremented to zero
    $count /= 2;
    while($count){
        # Add the current count value, and its negative,
        # to opposite ends of the array, and decrement
        # it
        push(@ints, $count);
        unshift(@ints, -$count);
        $count--;
    }

    return(@ints);

}



