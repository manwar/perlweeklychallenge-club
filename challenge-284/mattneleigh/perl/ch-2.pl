#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integer_list_sets = (
    [
        [ 2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5 ],
        [ 2, 1, 4, 3, 5, 6 ]
    ],
    [
        [ 3, 3, 4, 6, 2, 4, 2, 1, 3 ],
        [ 1, 3, 2 ]
    ],
    [
        [ 3, 0, 5, 0, 2, 1, 4, 1, 1 ],
        [ 1, 0, 3, 2 ]
    ]
);

print("\n");
foreach my $integer_list_set (@integer_list_sets){
    printf(
        "Input: \@list1 = (%s)\n       \@list2 = (%s)\nOuput: (%s)\n\n",
        join(", ", @{$integer_list_set->[0]}),
        join(", ", @{$integer_list_set->[1]}),
        join(", ", relative_order_sort($integer_list_set))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two lists of integers, a primary and a secondary- whose members must be
# distinct and also present in the primary- sort the elements in the primary
# such that their relative order is the same as their order in the secondary,
# with elements in the primary NOT present in the secondary being sorted in
# ascending order but placed after all elements that ARE present in the
# secondary
# Takes one argument:
# * A ref to an array of two arrays of integers, comprising the primary and
#   secondary integer lists; all elements in the secondary list must be
#   distinct and present in the primary list (e.g.
#       [
#           # Primary list
#           [ 2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5 ],
#           # Secondary list
#           [ 2, 1, 4, 3, 5, 6 ]
#       ]
#   )
# Returns:
# * A list of integers sorted according to the procedure described above (e.g.
#   ( 2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9 ) )
################################################################################
sub relative_order_sort{
    my $integer_lists = shift();

    my $int;
    my %present;
    my %bucket;
    my @junk_drawer;

    # Take note of where each element of the secondary
    # list appears- temporarily using $int to hold
    # index values
    $int = 0;
    %present = map(
        { $_ => $int++ }
        @{$integer_lists->[1]}
    );

    # Examine every integer in the primary list
    foreach $int (@{$integer_lists->[0]}){
        if(defined($present{$int})){
            # This integer was in the secondary list- store
            # it in the correct bucket for the matching index
            # from the secondary list
            push(
                @{$bucket{$present{$int}}},
                $int
            );
        } else{
            # This integer was NOT in the secondary list-
            # store it in the junk drawer list
            push(@junk_drawer, $int);
        }
    }

    # Combine each bucket's contents, in the correct
    # order, with the sorted contents of the junk drawer
    # list
    return(
        map(
            @{$bucket{$_}},
            sort({ $a <=> $b } keys(%bucket))
        ),
        sort({ $a <=> $b } @junk_drawer)
    );

}



