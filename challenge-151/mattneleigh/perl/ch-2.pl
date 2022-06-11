#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

# The houses on multiple streets
my @streets = (
    # Given cases
    [ 2, 4, 5 ],
    [ 4, 2, 3, 6, 5, 3 ],

    # Additional test cases
    [ 3, 9 ],
    [ 4 ],
    [ ],

    # This one kind of shows the limitations
    # of the starting condition...
    [ 1, 50, 2, 3, 7, 4 ]
);
my $street;

print("\n");

foreach $street (@streets){
    printf(
        "The street with houses containing valuables: %s\n",
        join(", ", @{$street})
    );
    printf(
        "    will yield a total of %d loot.\n\n",
        calculate_loot_yield_on_street(@{$street})
    );
}

print("DISCLAIMER: Do not actually rob houses- it's not nice!\n\n");

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Determine the maximum amount of loot that can be gotten by robbing houses on
# a street, given certain parameters and restrictions, including a requirement
# to rob the first house on the street, and not to rob any two adjacent houses
# Takes one argument:
# * A list of the quantities of loot available in each house on the street
# Returns:
# * The maximum amount of loot that can be gotten within the restrictions
#   specified, which will be zero (0) if the supplied list is empty
# Shamelessly adapted from an algorithm seen at:
# https://www.geeksforgeeks.org/find-maximum-possible-stolen-value-houses/
# DISCLAIMER: Do not actually rob houses- it's not nice!
################################################################################
sub calculate_loot_yield_on_street{
    use List::Util qw(max);

    # Empty list, no houses to rob
    return(0)
        unless(@ARG);

    my @loot;
    my $loot_initial;
    my $i;

    # We always start with the first house, as
    # specified (though this seems limiting...)
    $loot_initial = $ARG[0];

    # Strip off the first two houses- we've
    # robbed the first and can't rob the second
    splice(@ARG, 0, 2);

    # Edge cases- zero or one houses left
    return($loot_initial)
        unless(@ARG);
    if(scalar(@ARG) == 1){
        return($loot_initial + $ARG[0]);
    }

    # Proceed as normal(?)
    $loot[0] = $ARG[0];
    $loot[1] = max($ARG[0], $ARG[1]);

    for($i = 2; $i < scalar(@ARG); $i++){
        $loot[$i] = max($ARG[$i] + $loot[$i - 2], $loot[$i - 1]);
    }

    return($loot_initial + $loot[$#loot]);

}



