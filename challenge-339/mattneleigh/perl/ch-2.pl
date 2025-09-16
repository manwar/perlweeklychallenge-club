#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @altitude_gain_sets = (
    [ -5, 1, 5, -9, 2 ],
    [ 10, 10, 10, -25 ],
    [ 3, -4, 2, 5, -6, 1 ],
    [ -1, -2, -3, -4 ],
    [ -10, 15, 5 ]
);

print("\n");
foreach my $altitude_gains (@altitude_gain_sets){
    printf(
        "Input: \@gain = (%s)\nOutput: %d\n\n",
        join(", ", @{$altitude_gains}),
        maximum_altitude(@{$altitude_gains})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of altitude gains and losses, determine the maximum altitude
# achieved, assuming a start at zero
# Takes one argument:
# * A list of altitude gains and losses (e.g. (3, -4, 2, 5, -6, 1) )
# Returns:
# * The maximum altitude achieved (e.g. 6)
################################################################################
sub maximum_altitude{

    my $altitude = 0;
    my $max = 0;

    # Loop over all the gain values, apply each to
    # the current altitude, and see if that yields
    # a value bigger than any yet seen
    foreach my $gain (@ARG){
        $altitude += $gain;
        $max = $altitude
            if($altitude > $max);
    }

    return($max);

}



