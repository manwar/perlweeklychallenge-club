#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @data_sets = (
    [
        [ 1, 2, 3, 4, 5 ],
        2
    ],
    [
        [ 1, 2, 3, 4, 5, 6 ],
        3
    ],
    [
        [ 1, 2, 3 ],
        2
    ],
    [
        [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ],
        5
    ],
    [
        [ 1, 2, 3 ],
        4
    ],
    [
        [ 72, 57, 89, 55, 36, 84, 10, 95, 99, 35 ],
        7
    ]
);

print("\n");
foreach my $data_set (@data_sets){
    my @sub_lists = divide_list($data_set->[1], @{$data_set->[0]});

    printf(
        "Input: \@list = (%s), \$n = %d\nOutput: %s\n\n",
        join(", ", @{$data_set->[0]}),
        $data_set->[1],
        @sub_lists ?
            "(" .
            join(
                ", ",
                map(
                    "(" . join(", ", @{$_}) . ")",
                    @sub_lists
                )
            )
            . ")"
            :
            -1
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Divide a list into a specified number of sublists, placing an equal number of
# elements into each if possible; if this is not possible, a number of initial
# sublists equal to the remainder of the number of original list members
# divided by the number of desired sub-lists will each have one more member
# than the rest (see the example below).  If the specfied number of sublists
# exceeds the number of elements in the original list, an empty list will be
# returned.  Lists of any scalar type are accepted.
# Takes two arguments:
# * The number of sections into which to divide the list (e.g. 7 )
# * The list to divide into sublists (e.g. ( 72, 57, 89, 55, 36, 84, 10, 95,
#   99, 35 ) )
# Returns:
# * A list of refs to sub-lists populated with members from the original list,
#   divided as specified above (e.g.
#   (
#       [ 72, 57 ], [ 89, 55 ], [ 36, 84 ], [ 10 ], [ 95 ], [ 99 ], [ 35 ]
#   )
#   Note that as 10 % 7 is 3, the first three lists have one more member than
#   the others
# - OR -
# * An empty list (e.g. () ) if there were not enough members in the original
#   list to make the specified number of sublists containing at least one
#   member
################################################################################
sub divide_list{
    my $sublist_count = shift();
    my @source_list = @ARG;

    my $nmemb = scalar(@source_list);

    # If we can't populate at $sublist_count
    # lists with at least one member, return an
    # empty list
    return(())
        if($sublist_count > $nmemb);

    # Calculate the number of members each
    # sublist will have, and how many will have
    # an extra element
    my $members = int($nmemb / $sublist_count);
    my $extra = $nmemb % $sublist_count;

    return(
        map(
            [
                # Extract the specified number of members
                # from the source list for inclusion in a new
                # sublist, adding an extra member if required
                splice(
                    @source_list,
                    0,
                    $members + ($_ < $extra ? 1 : 0),
                    ()
                )
            ],
            0 .. $sublist_count - 1
        )
    );

}



