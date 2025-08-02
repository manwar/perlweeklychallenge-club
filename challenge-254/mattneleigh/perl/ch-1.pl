#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @ints = (
    # Given cases
    27, 0, 6,

    # Additional test cases
    3375, -3375, 1073741824
);

print("\n");
foreach my $int (@ints){
    printf(
        "Input: \$n = %d\nOutput: %s\n\n",
        $int,
        is_power_of_three($int) ?
            "true"
            :
            "false"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an integer, determine whether that integer is a power of three
# Takes one argument:
# * The integer to examine
# Returns:
# * 1 if the integer appears to be another integer raised to the third power
# * 0 if the integer does NOT appear to be another integer raised to the third
#   power
################################################################################
sub is_power_of_three{

    # Compute the cube root of the first argument-
    # with a bit of trickery required for negative
    # values
    my $cuberoot = ($ARG[0] < 0) ?
        -((-$ARG[0]) ** (1/3))
        :
        $ARG[0] ** (1/3);

    return(
        # Account for round-off error- see if $cuberoot
        # is very close to being an integer
        abs($cuberoot - sprintf("%.0f", $cuberoot)) < 0.000001 ?
            1
            :
            0        
    );

}



