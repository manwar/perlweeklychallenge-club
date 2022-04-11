#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @arrays = (
    [1, 3, 5, 7, 9],
    [1, 2, 3, 4, 5],
    [2, 4, 2]
);
my $array;

print("\n");
foreach $array (@arrays){
    my $rval = calculate_equilibrium_index(@{$array});

    printf(
        "Input: \@n = (%s)\nOutput: %s\n\n",
        join(", ", @{$array}),
        (
            $rval < 0
            ?
            $rval . " as no Equilibrium Index could be found."
            :
            $rval
        )
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the Equilibrium Index of an array of numbers- that is to say, the
# index at which the sum of the values behind (but not including) the index is
# equal to the sum of the values ahead (but not including) the index.  There
# must be at least three elements in the array for this calculation to take
# place.
# Takes one argument:
# * The list to examine
# Returns:
# * The Equilibrium Index, or -1 if no Equilibrium Index can be found, which
#   includes cases where the array contains fewer than three elements
################################################################################
sub calculate_equilibrium_index{

    # Can't have an equilibrium index if there
    # aren't at least three elements
    return(-1)
        if(scalar(@ARG) < 3);

    my $fore = 0;
    my $aft = $ARG[0];
    my $i = 1;

    # Compute the fore total
    for(2 .. $#ARG){
        $fore += $ARG[$_];
    }
    
    # Loop from 1 to ($#ARG - 1)
    while($i < $#ARG){
        if($aft == $fore){
            # Found an equilibrium index- return it
            return($i);
        }

        # Advance the index, adjusting the fore and
        # aft totals
        $aft += $ARG[$i];
        $fore -= $ARG[++$i];
    }

    # No equilibrium index found
    return(-1);

}



