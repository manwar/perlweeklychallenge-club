#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @hour_lists = (
    [ 12, 12, 30, 24, 24 ],
    [ 72, 48, 24, 5 ],
    [ 12, 18, 24 ]
);

print("\n");
foreach my $hour_list (@hour_lists){
    printf(
        "Input: \@hours = (%s)\nOutput: %d\n\n",
        join(", ", @{$hour_list}),
        count_complete_day_pairs(@{$hour_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers that represent a length of time in whole hours from
# a common reference datum, determine how many pairs of these form a complete
# day- that is to say, there is an exact multiple of 24 between them; the
# integers need not be sorted
# Takes one argument:
# * A list of integers that represent a length of time in whole hours from a
#   common reference datum (e.g. ( 72, 48, 24, 5 ) )
# Returns:
# * The number of pairs of times that form a complete day (e.g. 3 )
################################################################################
sub count_complete_day_pairs{

    my $day_pairs = 0;

    # Loop over every pair in the list
    for my $i (0 .. $#ARG - 1){
        for my $j ($i + 1 .. $#ARG){
            # Increment the day pair counter if there is no
            # remainder when dividing the difference between
            # members of this pair by 24
            $day_pairs++
                unless(($ARG[$j] - $ARG[$i]) % 24);
        }
    }

    return($day_pairs);

}



