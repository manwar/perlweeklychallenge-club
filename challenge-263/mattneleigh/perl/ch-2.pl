#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @item_sets = (
    [
        [ [1, 1], [2, 1], [3, 2] ],
        [ [2, 2], [1, 3] ]
    ],
    [
        [ [1, 2], [2, 3], [1, 3], [3, 2] ],
        [ [3, 1], [1, 3] ]
    ],
    [
        [ [1, 1], [2, 2], [3, 3] ],
        [ [2, 3], [2, 4] ]
    ]
);

print("\n");
foreach my $item_set (@item_sets){
    printf(
        "Input: \$items1 = [ %s ]\n       \$items2 = [ %s ]\n"
        .
        "Output: [ %s ]\n\n",
        item_list_to_string(@{$item_set->[0]}),
        item_list_to_string(@{$item_set->[1]}),
        item_list_to_string(merge_item_totals($item_set))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given two or more lists of pairs of item ID numbers and quantities, produce
# a merged list of all items with combined totals
# Takes one argument:
# * A ref to a data structure containing two or more lists of item ID numbers
#   and quantities; note that item IDs need not be sorted or unique in any list
#   (e.g.
#       [
#           [ [1, 2], [2, 3], [1, 3], [3, 2] ],
#           [ [3, 1], [1, 3] ]
#       ]
#   )
# Returns:
# * A list of unique item IDs and combined totals from both lists, sorted by
#   item ID number (e.g.
#       ( [ 1, 8 ], [ 2, 3 ], [ 3, 3 ] )
#   )
################################################################################
sub merge_item_totals{

    my %items;

    # Examine every given list
    foreach my $list (@{$ARG[0]}){
        # Examine every item in the list
        foreach my $item (@{$list}){
            # Check if this ID exists in the table
            if($items{$item->[0]}){
                # Have this ID already- add to its total
                $items{$item->[0]}[1] += $item->[1];
            } else{
                # Don't have this ID yet- store a copy of
                # the item
                $items{$item->[0]} = [ @{$item} ];
            }
        }
    }

    # Build/return a list of the new item
    # totals
    return(
        map(
            $items{$_},
            sort(keys(%items))
        )
    );

}



################################################################################
# Produce a printable string from a list of items
# Takes one argument:
# * A list of items, as an array of pairs of stock IDs and quantities (e.g.
#       (
#           [ 1, 2 ], [ 4, 3 ], [ 3, 7 ]
#       )
#   )
# Returns:
# * A string represneting the items as they appeared in the input list (e.g.
#   "[ 1, 2 ],  [ 4, 3 ],  [ 3, 7 ]" ).  Note that if any additional exterior
#   parentheses or braces are required, the caller must prepend/append these to
#   the returned string.
################################################################################
sub item_list_to_string{

    return(
        join(
            ",  ",
            map(
                "[ "
                .
                join(
                    ", ",
                    @{$_}
                )
                .
                " ]",
                @ARG
            )
        )
    );

}



