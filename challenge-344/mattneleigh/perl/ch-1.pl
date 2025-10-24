#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @array_sets = (
    [ [ 1, 2, 3, 4 ],         12 ],
    [ [ 2, 7, 4 ],           181 ],
    [ [ 9, 9, 9 ],             1 ],
    [ [ 1, 0, 0, 0, 0 ],    9999 ],
    [ [ 0 ],                1000 ]
);

print("\n");
foreach my $array_set (@array_sets){
    printf(
        "Input: \@ints = (%s), \$x = %d\nOutput: (%s)\n\n",
        join(", ", @{$array_set->[0]}),
        $array_set->[1],
        join(", ", add_array_form($array_set))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given an array of single digits that together comprise an integer, and an
# additional integer addend, add the latter to the value defined by the digits
# of the former
# Takes one argument:
# * A ref to an array that contains the array of digits and the additional
#   integer value (e.g. [ [ 2, 7, 4 ], 181 ] )
# Returns:
# * An array of digits that make up the value of the original digits plus the
#   additional integer (e.g. (4, 5, 5) )
################################################################################
sub add_array_form{

    return(
        # 2. Split the sum into its component digits
        split(
            //,
            # 1. Join the digits from the list into a single
            # integer, and add the additional integer to it
            join("", @{$ARG[0][0]}) + $ARG[0][1]
        )
    );

}



