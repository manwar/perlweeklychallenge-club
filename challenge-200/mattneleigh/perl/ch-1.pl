#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @arrays = (
    # Given cases
    [ 1,2,3,4 ],
    [ 2 ],

    # Additional test cases
    [ 1, 3, 9 ],
    [ 1, 2, 3 ],
    [ 5, 7, 6, 9, 4 ],
    [ 4, 6, 8, 12, 10, 9, 8, 7 ],
    [ 5, 5, 5, 5 ]
);

print("\n");
foreach my $array (@arrays){
    my @slices = find_arithmetic_slices(@{$array});

    printf(
        "Input: \@array = (%s)\nOutput: %s\n\n",
        join(", ", @{$array}),
        scalar(@slices)
            ?
            join(
                ", ",
                map(
                    sprintf("(%s)", join(", ", @{$_})),
                    @slices
                )
            )
            :
            "() as no slice found."
    )
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find the arithmetic slices within an array of integers- that is to say, those
# sub-sections of the array where at least three consecutive numbers have the
# same difference among all adjacent pairs
# Takes one argument:
# * The array to examine (e.g. ( 1, 2, 3, 4, 8, 6, 4 ) )
# Returns on success:
# * A list of refs to arrays that represent the arithmetic slices found within
#   the array (e.g. ( [ 1, 2, 3 ], [ 1, 2, 3, 4 ], [ 2, 3, 4 ], [ 8, 6, 4 ] )
# NOTE: If no arithmetic slices are found, OR if the input array has fewer than
# three members (by definition there cannot be an arithmetic slice in an array
# of one or two numbers) then the returned list will be empty
################################################################################
sub find_arithmetic_slices{

    my @slices = ();

    # Only process the array if there are more than
    # two elements in it
    if(scalar(@ARG) > 2){
        # Run this position from the start of the array to
        # two elements short of the end
        for my $base (0 .. ($#ARG - 2)){
            my $initial_diff = $ARG[$base + 1] - $ARG[$base];

            # Run this position from two elements ahead of $base
            # to the end of the array
            for my $lookahead (($base + 2) .. $#ARG){
                my $local_diff = $ARG[$lookahead]
                    - $ARG[$lookahead - 1];

                # Break the inner loop if differences
                # don't match
                last
                    unless($local_diff == $initial_diff);

                # Differences matched- store the slice
                push(
                    @slices,
                    [ @ARG[$base .. $lookahead] ]
                );
            }
        }
    }

    return(@slices);

}



