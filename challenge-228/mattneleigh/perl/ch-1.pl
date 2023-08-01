#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 1, 3, 2],
    [ 1, 1, 1, 1],
    [ 2, 1, 3, 4]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@int = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        sum_unique_integers(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the sum of the unique elements in an array of integers
# Takes one argument:
# * An array of integers (e.g. ( 2, 1, 3, 2 ) )
# Returns:
# * The sum of all numbers that appear only once in the array (e.g. 4 )
################################################################################
sub sum_unique_integers{

    my %counts;
    my $total = 0;

    # Loop over each number in the list
    foreach my $num (@ARG){
        # Skip numbers that have been seen twice
        # (unseen numbers are undef; numbers seen
        # once are zero; numbers seen twice are
        # one)
        next
            if($counts{$num});

        if(defined($counts{$num})){
            # Second time seeing this number-
            # subtract it from the total and mark
            # it to be skipped
            $total -= $num;
            $counts{$num} = 1;
        } else{
            # First time seeing this number- add it
            # to the total and mark it as seen once
            $total += $num;
            $counts{$num} = 0;
        }
    }

    return($total);

}



