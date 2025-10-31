#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 3, 2 ],
    [ 2, 4, 6, 5, 3 ],
    [ 1, 2, 3, 2, 4, 1 ],
    [ 5, 3, 1 ],
    [ 1, 5, 1, 5, 1, 5, 1 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", find_peaks(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers, determine which values are peaks- values which are
# greater than the adjacent values on either side, or greater than the value on
# the inward side if the value is at either end of the array
# Takes one argument:
# * A list of integers to examine (e.g. (1, 2, 3, 2, 4, 1) )
# Returns:
# * A list of indices of peaks found within the supplied list (e.g. (2, 4) )
################################################################################
sub find_peaks{

    my $i = 1;
    my @peaks;

    # See if the first value is a peak
    if($ARG[0] > $ARG[1]){
        # Store this index and skip over the next one
        push(@peaks, 0);
        $i++;
    }

    # Loop while the index is within the array
    # but NOT at either end
    while($i < $#ARG){
        if(($ARG[$i - 1] < $ARG[$i]) && ($ARG[$i] > $ARG[$i + 1])){
            # This mid-array value is a peak...
            # Store this index and skip over the next one,
            # which we know can't be a peak
            push(@peaks, $i);
            $i++;
        }

        # Advance within the list
        $i++;
    }

    # If we didn't skip over the end of the array and
    # the last element is a peak, store its index
    push(@peaks, $i)
        if(($i == $#ARG) && ($ARG[-1] > $ARG[-2]));

    return(@peaks);

}



