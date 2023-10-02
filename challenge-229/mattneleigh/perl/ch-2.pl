#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @array_sets = (
    [
        [ 1, 1, 2, 4 ],
        [ 2, 4 ],
        [ 4 ]
    ],
    [
        [ 4, 1 ],
        [ 2, 4 ],
        [ 1, 2 ]
    ]
);

print("\n");
foreach my $array_set (@array_sets){
    my $num = 1;

    printf(
        "Input: %s\nOutput: (%s)\n\n",
        join(
            "\n       ",
            map(
                sprintf("\@array%d = (%s)", $num++, join(", ", @{$_})),
                @{$array_set}
            )
        ),
        join(", ", find_common_array_elements($array_set))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Examine a set of arrays of integers and report which integers appear in at
# least two of the supplied arrays
# Takes one argument:
# * A ref to a list of array references (e.g
#       [
#           [ 1, 1, 2, 4 ],
#           [ 2, 4 ],
#           [ 4 ]
#       ]
#   )
# Returns:
# * A list, sorted in ascending order, of integers that appear in at least two
#   of the supplied arrays (e.g. ( 2, 4 ) )
################################################################################
sub find_common_array_elements{
    my $arrays = shift();

    my %totals;

    # Examine each array
    foreach my $array (@{$arrays}){
        my %instances;
        my $element;

        # Note that each element has been seen;
        # duplicate elements will only be
        # represented once
        foreach $element (@{$array}){
            $instances{$element} = 1;
        }

        # Initialize or increment each element's
        # global total
        foreach $element (keys(%instances)){
            if($totals{$element}){
                $totals{$element}++;
            } else{
                $totals{$element} = 1;
            }
        }
    }

    # Return a sorted list of elements
    # counted more than once (seen in more
    # than one array)
    return(
        map(
            $totals{$_} > 1 ? $_ : (),
            sort(keys(%totals))
        )
    );

}



