#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 20, 3 ],
    [ 3, 30, 34, 5, 9 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        construct_largest_number(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the largest number that can be created by concatenating a list of
# positive integers, in any order required
# Takes one argument:
# * The list of integers to examine (e.g. ( 3, 30, 34, 5, 9 ) )
# Returns:
# * The largest number that could be concatenated from the given integers (e.g.
#   9534330 )
################################################################################
sub construct_largest_number{

    return(
        # 2. Combine all the numbers together into a
        # single string
        join(
            "",
            # 1. Sort the numbers into the necessary order
            sort(
                {
                    # Determine which combination of digits produces
                    # the larger number
                    ($a . $b) > ($b . $a) ?
                        -1
                        :
                        1
                }
                @ARG
            )
        )
    );

}



