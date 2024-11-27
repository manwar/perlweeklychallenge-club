#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 0 ],
    [ 0, 1, 0 ],
    [ 0, 0, 0, 0, 0 ],
    [ 0, 1, 0, 0, 1, 0 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@binary = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        longest_contiguous_balanced_segment(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of ones (1's) and zeros (0's), determine the length of the
# longest segment with an equal number of ones and zeros therein.
# Takes one argument:
# * The list of binary integers to examine (e.g. ( 0, 1, 0, 0, 1, 0 ) )
# Returns:
# * The length of the longest segment that has an equal number of 1's and 0's
#   (e.g. 4 )
# * 0 if no segment could be found in which the number of 1's and 0's was equal
################################################################################
sub longest_contiguous_balanced_segment{
    use POSIX qw(floor);

    my $max_pairs = floor(scalar(@ARG) / 2);

    # Try every even window that fits within
    # the array- using an even size since no
    # odd-sized window could meet the search
    # criteria; search backward so the first
    # window we find that meets search criteria
    # will be the max
    foreach my $window_size (map(($max_pairs - $_) * 2, 0 .. $max_pairs - 1)){
        my $total = 0;
        
        # Move the window along the array
        foreach my $start (0 .. scalar(@ARG) - $window_size){
            if($start){
                # Second iteration or later- subtract the
                # element going out of the window and add
                # the one coming into the window
                $total -= $ARG[$start - 1] ? 1 : -1;           
                $total += $ARG[$start + ($window_size - 1)] ? 1 : -1;           
            } else{
                # First iteration- establish a total for the
                # window at index 0
                for my $i (0 .. $window_size - 1){
                    $total += $ARG[$i] ? 1 : -1;
                }
            }

            # If we had an even number of 1's and 0's,
            # within the window, $total will be zero, so
            # we return this window size, for it will be
            # the maximum
            return($window_size)
                unless($total);
        }
    }

    # Got here- no matching window found
    return(0);

}



