#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    # Given cases
    [ 5, 2, 9, 1, 7, 6 ],
    [ 4, 2, 3, 1, 5, 0 ],

    # Additional test case
    [ 1, 9, 2, 4, 9, 7 ]
);

print("\n");
foreach(@lists){
    printf("Input: \@n = (%s)\n", join(", ", @{$_}));
    print("Output: ", index_largest_element(@{$_}), "\n\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the index of the largest value in a list of numbers
# Takes one argument:
# * The list of numbers to examine
# Returns:
# * The index of the largest value in the list; if the largest value occurs
#   more than once, the FIRST instance will be reported
################################################################################
sub index_largest_element{

    my $max = 0;
    my $index;

    # Loop over the list, updating max value and
    # the index where we saw it if the current
    # value is larger than the previous max
    for my $i (0 .. $#_){
        if($_[$i] > $max){
            $max = $_[$i];
            $index = $i;
        }
    }
    
    return($index);

}



