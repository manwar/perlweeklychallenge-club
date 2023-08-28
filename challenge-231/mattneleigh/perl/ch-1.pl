#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_lists = (
    [ 3, 2, 1, 4 ],
    [ 3, 1 ],
    [ 2, 1, 3 ]
);

print("\n");
foreach my $integer_list (@integer_lists){
    my @remaining = copy_without_outliers(@{$integer_list});

    printf(
        "Input: \@ints = (%s)\nOutput: %s\n\n",
        join(", ", @{$integer_list}),
        defined($remaining[0]) ?
            "(" . join(", ", @remaining) . ")"
            :
            "-1"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Copy a list of integers, omitting the highest and lowest values from said
# list
# Takes one argument:
# * The list of integers to examine (e.g. ( 1, 2, 3, 4, 5, 6 ) )
# Returns on success:
# * A copy of the initial list, with the highest and lowest valued elements
#   omitted (e.g. ( 2, 3, 4, 5 ) )
# Returns on error:
# * undef if there are not at least three elements in the list
################################################################################
sub copy_without_outliers{

    my $min = ~0;
    my $min_index;
    my $max = -~0;
    my $max_index;

    # Return undef if we don't have enough integers
    # to remove a min and max
    return(undef)
        if(scalar(@ARG) < 3);

    # Loop over each element in the list
    for my $i (0 .. $#ARG){
        if($ARG[$i] < $min){
            # This is a new min- make a note of it and its
            # location
            $min = $ARG[$i];
            $min_index = $i;
        }
        if($ARG[$i] > $max){
            # This is a new max- make a note of it and its
            # location
            $max = $ARG[$i];
            $max_index = $i;
        }
    }

    # If the minimum occurred before the maximum,
    # decrement $max_index because deletion of the
    # min will shift the max closer to zero
    $max_index--
        if($min_index < $max_index);

    # Delete the min and max elements from
    # the array
    splice(@ARG, $min_index, 1);
    splice(@ARG, $max_index, 1);

    return(@ARG);

}



