#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 0, 2, 1, 5, 3, 4 ],
    [ 5, 0, 1, 2, 3, 4 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    printf(
        "Input: \@int = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$integer_list}),
        join(", ", rearrange_integers(@{$integer_list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Rearrange an array of integers into a new array such that:
#   $new[$i] = $old[$old[$i]] for all $i within the bounds of the two arrays
# Takes one argument:
# * The array of integers to rearrange (e.g. ( 0, 2, 1, 5, 3, 4 ) )
# Returns:
# * The rearranged array (e.g. ( 0, 1, 2, 4, 5, 3 ) )
################################################################################
sub rearrange_integers{

    return(
        # Loop over all array indices
        map(
            # Pretty much straight from the problem
            # spec...
            $ARG[$ARG[$_]],
            0 .. $#ARG
        )
    );

}



