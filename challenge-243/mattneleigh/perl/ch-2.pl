#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 2, 5, 9 ],
    [ 7, 7, 7, 7, 7, 7, 7 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@nums = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        calculate_quotient_floor_sum(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the sum of the floor (integer value, rounded down) of the quotients
# of every possible pair of numbers described by two sets of indices within a
# list of positive integers- including those where the indices are the same
# Takes one argument:
# * A list of integers to examine
# Returns:
# * The sum of the floor (integer value, rounded down) of the quotients of
#   every possible pair of numbers described by two sets of indices within a
#   list- including those where the indices are the same
################################################################################
sub calculate_quotient_floor_sum{
    use POSIX;

    my $sum = 0;

    # Loop such that $i and $j take on every
    # possible index- even cases where they're
    # both the same
    for my $i (0 .. $#ARG){
        for my $j (0 .. $#ARG){
            # Add the floor of the quotient of this
            # pair's members to the sum
            $sum += floor($ARG[$i] / $ARG[$j]);
        }
    }

    return($sum);

}



