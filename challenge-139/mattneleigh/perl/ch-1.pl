#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    [1,2,3,4,5],
    [1,3,2,4,5]
);
my $list;

foreach $list (@lists){
    print("Input: \@n = (", join(",", @{$list}), ")\n");
    print("Output: ", jort_sort(@{$list}), "\n\n");
}


exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################


################################################################################
# Perform the Jort Sort on an array of numbers
# Takes one argument:
# * A list of numbers to examine
# Returns:
# * 1 if the list is sorted in ascending order
# * 0 if the list is NOT sorted in ascending order
################################################################################
sub jort_sort{

    my $i = $#ARG;

    # For n members in the list, loop
    # n-1 times
    while($i--){
        # If any member of the list is larger
        # than the following member, return
        # zero.
        return(0) if($ARG[$i] > $ARG[$i + 1]);
    }

    # Made it through the list- must have
    # been sorted
    return(1);

}



