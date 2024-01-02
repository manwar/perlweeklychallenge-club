#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 0, 1, 2 ],
    [ 4, 3, 2, 1 ],
    [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@ints = (%s)\nOutput: %d\n\n",
        join(", ", @{$integer_list}),
        match_index_mod_ten(@{$integer_list})
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of integers, determine the first index at which the value stored
# at that index equals the index-mod-10 (i.e. $i % 10 == $ints[$i] )
# Takes one argument:
# * The list of integers to examine
# Returns on success:
# * The first index at which the value in the list at that index is equal to
#   the index mod ten
# Returns on error:
# * -1 if no index/value pair that matches the search criteria is found
################################################################################
sub match_index_mod_ten{

    # Loop over every index in the array
    for my $i (0 .. $#ARG){
        # Return the first index in which the
        # index mod 10 equals the value stored
        # at that index
        return($i)
            if($i % 10 == $ARG[$i]);
    }

    # Didn't find a matching value...
    return(-1);

}



