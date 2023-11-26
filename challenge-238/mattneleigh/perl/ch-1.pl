#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 1, 2, 3, 4, 5 ],
    [ 1, 1, 1, 1, 1 ],
    [ 0, -1, 1, 2 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@int = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", running_sum(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the running sum of a sequence of integers- that is to say, produce
# a list of sums such that: $sums[$i] = $nums[0] + $nums[1] + ... + $nums[$i]
# Takes one argument:
# * A list of integers (e.g. ( 1, 1, 1, 1, 1 ) )
# Returns:
# * A list of running sums of the supplied integers (e.g. ( 1, 2, 3, 4, 5 ) )
################################################################################
sub running_sum{

    my $sum = 0;

    return(
        # Add each number to the sum, with each
        # sum going into the list to be returned
        map(
            $sum += $_,
            @ARG
        )
    );

}



