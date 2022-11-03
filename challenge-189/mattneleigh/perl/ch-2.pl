#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @arrays = (
    [ 1, 3, 3, 2 ],
    [ 1, 2, 1, 3 ],
    [ 1, 3, 2, 1, 2 ],
    [ 1, 1, 2, 3, 2 ],
    [ 2, 1, 2, 1, 1 ]
);

print("\n");
foreach my $array (@arrays){
    printf(
        "Input: \@array = (%s)\nOutput: (%s)\n\n",
        join(", ", @{$array}),
        join(", ", find_shortest_slice_of_max_degree(@{$array}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Find the shortest slice of an array with the same degree (maximum frequency
# of any given element) as the original
# integers.
# Takes one argument:
# * The list to examine (e.g. ( 1, 1, 2, 3, 2 ) )
# Returns:
# * The shortest slice of the original array that also has the same degree as
#   the original (e.g. ( 1, 1 ) )
################################################################################
sub find_shortest_slice_of_max_degree{

    my %degree_records;
    my $degree_key;

    # Loop over the array
    for my $i (0 .. $#ARG){
        # See if there's a record for this value
        if(defined($degree_records{$ARG[$i]})){
            # Record already established- increment
            # degree and update slice end
            $degree_records{$ARG[$i]}[0]++;
            $degree_records{$ARG[$i]}[2] = $i;
        } else{
            # Establish a new record:
            # degree, slice start, slice end
            $degree_records{$ARG[$i]} = [1, $i, $i];
        }
    }

    # The key that floats to the top of this
    # sort is the one we want:
    ($degree_key) = sort(
        {
            # Sort on the degree of this key in
            # DESCENDING order...
            ($degree_records{$b}[0] <=> $degree_records{$a}[0])
            ||
            # ...BUT, if the degrees are equal, sort on
            # the length of the array slice in
            # ASCENDING order
            (
                ($degree_records{$a}[2] - $degree_records{$a}[1])
                <=>
                ($degree_records{$b}[2] - $degree_records{$b}[1])
            )
        }
        keys(%degree_records)
    );

    # Return the array slice defined by the
    # values stored under the key found above
    return(
        @ARG[
            $degree_records{$degree_key}[1]
            ..
            $degree_records{$degree_key}[2]
        ]
    );

}



