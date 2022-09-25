#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################


my @lists = (
    # Given cases
    [ [1, 2],  [3, 4],  [5, 6],  [1, 2] ],
    [ [9, 1],  [3, 7],  [2, 5],  [2, 5] ],

    # Additional test case(s)
    [ [0, 0], [0, 0, 0], [0], [0, 0], [0, 0, 0, 0] ]
);

printf("\n");
foreach my $list (@lists){
    printf(
        "Input: \@list = %s\n",
        stringify_array_of_arrays(@{$list})
    );
    printf(
        "Output: %s\n\n",
        stringify_array_of_arrays(copy_unique_elements(@{$list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################


################################################################################
# Given an array of arrays (2D array), create an array of the unique sub arrays
# from the original (e.g., given ( [1, 2],  [3, 4],  [5, 6],  [1, 2] ), returns
# ( [1, 2], [3, 4], [5, 6] ) ).  The overall array need not be rectangular, nor
# do the data stored within need to be numeric.
# Takes one argument:
# * The array of arrays to examine
# Returns:
# * An array of unique sub-arrays from the original array
# NOTE: The returned array will contain REFERENCES to the original data, thus
# subsequent alterations to any of the unique sub-arrays this function finds
# will be reflected in both the original AND the copy.
################################################################################
sub copy_unique_elements{

    my @unique;
    my %content_table;

    foreach(@ARG){
        my $key = join(":", @{$_});

        unless(defined($content_table{$key})){
            push(@unique, $_);
            $content_table{$key} = 1;
        }
    }

    return(@unique);

}



################################################################################
# Produce a string that contains the contents of a 2D array (array of array
# refs)
# Takes one argument:
# * The array of arrays to examine (e.g. ([1, 2], [3, 4, 5], [6, 7]) )
# Returns:
# * A printable string representing the contents of the array (e.g.
#   "([1, 2], [3, 4, 5], [6, 7])" )
################################################################################
sub stringify_array_of_arrays{

    return(
        sprintf(
            "(%s)",
            join(
                ", ",
                map(
                    sprintf("[%s]", join(", ", @{$_})),
                    @_
                )
            )
        )
    );

}



