#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ -3, 1, 2, -1, 3, -2, 4 ],
    [ -1, -2, -3, 1 ],
    [ 1,2 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        maximum_instances_by_sign(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the larger of the count of positive values or negative values
# within a list of integers
# Takes one argument:
# * A list of integers to examine (e.g. ( -3, 1, 2, -1, 3, -2, 4 ) )
# Returns:
# * The larger of the count of positive values or negative values (e.g. 4, as
#   there are four positive numbers, vs. three negative numbers)
# NOTE: As zero is neither positive nor negative, it is always ignored for
# counting purposes
################################################################################
sub maximum_instances_by_sign{

    my $pos = 0;
    my $neg = 0;

    foreach my $num (@ARG){
        # Zero is neither positive nor negative
        # so it would not be counted here;
        # otherwise update pos and neg totals
        $pos++
            if($num > 0);
        $neg++
            if($num < 0);
    }

    # Return the larger of the two totals
    return(
        $pos > $neg ?
            $pos
            :
            $neg
    );

}



