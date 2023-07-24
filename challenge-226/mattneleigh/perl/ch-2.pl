#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @things = (
    [ 1, 5, 0, 3, 5 ],
    [ 0 ],
    [ 2, 1, 4, 0, 3 ]
);

print("\n");
foreach my $ints (@things){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$ints}),
        count_steps_to_reduce_by_positive_minimums(@{$ints})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Count the steps required to reduce an array of integers that are zero or
# greater to an array of only zeros by subtracting the current minimum positive
# value in the array at each step from each remaining positive integer
# Takes one argument:
# * An array of integers @I where all $I[$i] <= 0
# Returns on success:
# * The number of steps required to reduce the array to all zeros by the
#   process described above
# Returns on error:
# * undef if there are negative values in the array
################################################################################
sub count_steps_to_reduce_by_positive_minimums{
    my @ints = @ARG;

    my $oldmin = ~0;
    my $subtracting = 1;
    my $steps = 0;

    # Find the initial positive minimum
    foreach my $int (@ints){
        return(undef)
            if($int < 0);
        $oldmin = $int
            if(($int < $oldmin) && ($int > 0));
    }

    # Loop while there still appears to be
    # work to do
    while($subtracting){
        my $newmin = ~0;

        # Loop over every int
        $subtracting = 0;
        foreach my $i (0 .. $#ints){
            if($ints[$i] > 0){
                # This was a positive int- subtract the old
                # minimum and see if the resulting value
                # might be the new minimum for the next step,
                # then note that we subtracted something
                $ints[$i] -= $oldmin;
                $newmin = $ints[$i]
                    if(($ints[$i] > 0) && ($ints[$i] < $newmin));
                $subtracting = 1;
            }
        }

        if($subtracting){
            # We did some work above- add a step, and
            # store the new minimum to be the next
            # iteration's old minimum
            $steps++;
            $oldmin = $newmin;
        }
    }

    return($steps);

}



