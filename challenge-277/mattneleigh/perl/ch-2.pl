#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @things = (
    [ 1, 2, 3, 4, 5 ],
    [ 5, 7, 1, 7 ]
);

print("\n");
foreach my $thing (@things){
    printf(
        "Input: \@ints = (%s)\nOuput: %s\n\n",
        join(", ", @{$thing}),
        count_strong_pairs(@{$thing})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a a list of integers, count the number of strong pairs among the unique
# members of the list- that is to say, those pairs of unique integers (say,
# (x, y)) such that 0 < |x - y| < min(x, y)
# Takes one argument:
# * The list of integers to examine (e.g. ( 5, 7, 1, 7 ) )
# Returns
# * The count of strong pairs among unique elements in the supplied array (e.g.
#   1 )
################################################################################
sub count_strong_pairs{
    use List::Util qw(uniq);

    # Get a list of unique integers from the
    # arguments we were given
    my @ints = uniq(@ARG);

    my $abs_diff;
    my $strong_pair_count = 0;

    # Loop over every pair of unique integers
    for my $i (0 .. $#ints - 1){
        for my $j ($i + 1 .. $#ints){
            $abs_diff = abs($ints[$j] - $ints[$i]);

            # Increment the count if this pair meets
            # the specified criteria
            $strong_pair_count++
                if(
                    0 < $abs_diff
                    &&
                    $abs_diff < ($ints[$i] < $ints[$j] ? $ints[$i] : $ints[$j])
                );
        }
    }

    return($strong_pair_count);

}



