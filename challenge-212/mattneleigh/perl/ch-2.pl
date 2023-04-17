#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    # Given cases
    [
        3,
        [ 1, 2, 3, 5, 1, 2, 7, 6, 3 ]
    ],
    [
        2,
        [ 1, 2, 3 ]
    ],
    [
        3,
        [ 1, 2, 4, 3, 5, 3 ]
    ],
    [
        3,
        [ 1, 5, 2, 6, 4, 7 ]
    ],

    # Additional test cases
    [
        3,
        [ 1, 5, 2, 9, 4, 7 ]
    ],
);

print("\n");
foreach my $list (@lists){
    my $result = even_split($list->[0], @{$list->[1]});

    printf(
        "Input: \@list = (%s) and \$size = %d\nOutput: %s\n\n",
        join(", ", @{$list->[1]}),
        $list->[0],
        defined($result) ?
            "[ " . list_of_lists_to_string(@{$result}) . " ]"
            :
            "-1"
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Split a list of integers into a number of sub-lists each containing the
# specified number of members; these sub-lists will also consist of members
# that are numerically sequential (that is to say, each is one greater than the
# number that preceded it)
# Takes two arguments:
# * The number of members to place in each sub-list (e.g. 3 )
# * The list of integers to examine (e.g. (1, 2, 4, 3, 5, 3) )
# Returns on success:
# * A ref to a list of sub-lists as described above (e.g. 
#   [ [ 1, 2, 3 ], [ 3, 4, 5 ] ] )
# Returns on error:
# * undef if a set of sub-lists as described above cannot be constructed from
#   the supplied data and parameter
################################################################################
sub even_split{
    my $n = int(shift());

    my $buckets;

    # Can we make equal groups?  Quantity of
    # integers must divide evenly by $n
    return(undef)
        if(scalar(@ARG) % $n);

    # Sort the numbers and prepare the right
    # quantity of buckets
    @ARG = sort(@ARG);
    $buckets = [ map([], 1 .. (scalar(@ARG) / $n)) ];

    # Loop while unplaced numbers remain
    while(@ARG){
        my $placed = 0;

        # Loop over each bucket
        for my $i (0 .. $#$buckets){
            # Skip this bucket if it's already full
            next
                if(scalar(@{$buckets->[$i]}) == $n);

            # See if this bucket is empty or this
            # number is one greater than the last
            # one added to the bucket
            if(
                (!scalar(@{$buckets->[$i]}))
                ||
                ($ARG[0] == ($buckets->[$i][$#{$buckets->[$i]}] + 1))
            ){
                # Transfer this number to the bucket and
                # skip ahead to the next number
                push(@{$buckets->[$i]}, shift(@ARG));
                $placed = 1;
                last;
            }
        }

        # Indicate an error if we couldn't place
        # this number
        return(undef)
            unless($placed);
    }

    return($buckets);

}



################################################################################
# Build a string out of a list of lists.  The data will be presented as the
# code that would produce an array ref of values containing the equivalent
# data.
# Takes one argument:
# * The list of lists to stringify (e.g. ( [ 1, 2 ], [ 3, 4 ] ) )
# Returns
# * A string containing a text representation of contents of the list of lists
#   (e.g. "[ 1, 2 ], [ 3, 4 ]" )
################################################################################
sub list_of_lists_to_string{

    return(
        join(
            ", ",
            map(
                sprintf(
                    "[ %s ]",
                    join(", ", @{$_})
                ),
                @ARG
            )
        )
    );

}



