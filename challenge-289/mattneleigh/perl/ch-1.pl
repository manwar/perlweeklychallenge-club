#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 5, 6, 4, 1 ],
    [ 4, 5 ],
    [ 1, 2, 2, 3 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        get_third_distinct_max(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of integers, find and report the third distinct maximum; if
# there are not three distinct maxima, report the first (largest) maximum
# Takes one argument:
# * A list of integers to examine (e.g. ( 5, 6, 4, 1 ) )
# Returns:
# * The third distinct maximum, if available, otherwise the largest maximum
#   (e.g. 4 )
################################################################################
sub get_third_distinct_max{
    use List::MoreUtils qw(uniq);

    # Grab only unique ints and sort those that
    # remain in descending order
    my @sorted = sort({ $b <=> $a } uniq(@ARG));

    # Return the third largest int if we have
    # enough left, or the largest if we don't
    return(
        scalar(@sorted) > 2 ?
            $sorted[2]
            :
            $sorted[0]
    );

}



