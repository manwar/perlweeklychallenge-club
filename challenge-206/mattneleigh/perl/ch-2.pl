#!/usr/bin/perl

use strict;
use warnings;
use English;

use List::Util qw(min max);

################################################################################
# Begin main execution
################################################################################

my @lists = (
    [ 1, 2, 3, 4 ],
    [ 0, 2, 1, 3 ]
);

print("\n");
foreach my $list (@lists){
    printf(
        "Input: \@array = (%s)\nOutput: %d\n\n",
        join(", ", @{$list}),
        max_sum_of_pair_mins(@{$list})
    );
}


exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the maximum of the sums of the minimums of each set of pairs within
# an array holding an even quantity of numbers
# Takes one argument:
# * An array of numbers with an even number of members
# Returns on success:
# * The maximum of the sums of the minimum values in each pair within the array
# Returns on error:
# * undef if the array has an odd number of members
################################################################################
sub max_sum_of_pair_mins{

    my @pairs;

    return(undef)
        if(scalar(@ARG) % 2);

    # Grab a list of all possible pairs within
    # the given array; do this with nested calls
    # to map() in which $i and the inner $_ will,
    # as array indices, refer to all pairs
    @pairs = map(
        {
            # Capture the outer $_
            my $i = $_;

            map(
                [ $ARG[$i], $ARG[$_] ],
                ($i + 1) .. $#ARG
            );
        }
        0 .. ($#ARG - 1)
    );

    # max() and min() are from List::Util
    return(
        # (2) ...then find the maximum value in
        # that list
        max(
            # (1) Generate a list of the sums of the
            # minima from each pair of pairs...
            map(
                (
                    min(@{$pairs[$_]})
                    +
                    min(@{$pairs[$#pairs - $_]})
                ),
                0 .. ($#pairs / 2)
            )
        )
    );

}



