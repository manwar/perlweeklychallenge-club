#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @lists = (
    [ 1, 2, 3, 2 ],
    [ 1, 3, 2 ],
    [ 1, 1, 2, 3 ],
    [ 2, 4, 3 ]
);

print("\n");
foreach my $list (@lists){
    printf(
        "Input: \@n = (%s);\nOutput: (%s)\n\n",
        join(", ", @{$list}),
        join(", ", find_special_triplet(@{$list}))
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a list of positive integers, find the triplet (a, b, c) from the list
# that satisfies the following rules:
#   1) a + b > c
#   2) b + c > a
#   3) a + c > b
#   4) a + b + c is the largest out of any triplet that satisfies the other
#      three rules
#   If more than one triplet satisties these rules, the one returned is the one
#   in which a >= b >= c.
# Takes one argument:
# * The list of integers to examine (e.g. (1, 2, 3, 2))
# Returns:
# * The triplet that satisfies the four rules defined above (e.g. (3, 2, 2))
#  -OR-
# * The empty list (e.g. ()) if no such triplet can be found
################################################################################
sub find_special_triplet{

    my @permutations;
    my @candidates;
    my $max = 0;
    my @max_set = ();

    # Generate a set of permutations of the
    # supplied numbers
    permute_list_sequence(\@ARG, 0, scalar(@ARG), \@permutations);

    foreach my $set (@permutations){
        # See if the first three rules apply to
        # this set's first three elements...
        if(
            (($set->[0] + $set->[1]) > $set->[2]) &&
            (($set->[1] + $set->[2]) > $set->[0]) &&
            (($set->[0] + $set->[2]) > $set->[1])
        ){
            my $sum = $set->[0] + $set->[1] + $set->[2];

            # See if the fourth rule applies...
            if($sum > $max){
                # New maximum; store the new value and
                # start a new list of qualifying
                # triplets
                $max = $sum;
                @max_set = ( [ @{$set}[0 .. 2] ] );
            } elsif($sum == $max){
                # Tied for the current maximum; add
                # this to the list of qualifying
                # triplets
                push(@max_set, [ @{$set}[0 .. 2] ]);
            }
        }
    }


    if(scalar(@max_set)){
        # At least one qualifying triplet was
        # found; sort them (they come in no
        # meaningful order from 
        # permute_list_sequence()) and return
        # the "largest"
        my $i = scalar(@{$max_set[0]});

        while($i--){
            # We can sort on multiple cells like
            # this since Perl's sort() is stable
            @max_set = sort({ $a->[$i] <=> $b->[$i] } @max_set);
        }

        return(@{$max_set[$#max_set]});

    } else{
        # No qualifying triplets were found;
        # return the empty list
        return();
    }

}



################################################################################
# Generate a sequence of permutations based on the contents of a supplied
# array.  Permutations will take place within the specified range of cells,
# which must be within the array or undefined behavior may result.  The
# permutations may not be generated in any particularly meaningful order.
# Takes four arguments:
# * A ref to an array of cells to permute.  NOTE: this array will be modified
#   as the permutations are generated; see the output array below for a copy of
#   the array in its original order
# * The index of the first cell (base) of the active permutation region
# * The number of cells, including the base, that will be part of the active
#   permutation region
# * A ref to an array in which the permutations are to be stored as output;
#   this will be populated with permuted copies of the entire original input
#   array, including cells outside the active permutation region, if any.  The
#   first array in this list will contain the cells in their unpermuted order.
# Returns:
# * undef at all times, which conveys no meaningful information
# Adapted from Heap's Algorithm as described here
# https://www.geeksforgeeks.org/heaps-algorithm-for-generating-permutations/
################################################################################
sub permute_list_sequence{
    my $list = shift();
    my $base = shift();
    my $region_size = shift();
    my $permutations = shift();

    # Active region is just one cell-
    # store a copy of the current list
    if($region_size == 1){
        push(@{$permutations}, [ @{$list} ]);
        return();
    }

    for(0 .. $region_size - 1){
        # Recurse deeper with a smaller active
        # region
        permute_list_sequence(
            $list,
            $base,
            $region_size - 1,
            $permutations
        );

        if($region_size % 2){
            # Odd range size- swap first and last
            # elements in the active region
            @{$list}[$base, $base + $region_size - 1]
                = @{$list}[$base + $region_size - 1, $base];
        } else{
            # Even range size- swap the $_th and
            # last elements in the active region
            @{$list}[$base + $_, $base + $region_size - 1]
                = @{$list}[$base + $region_size - 1, $base + $_];
        }
    }

    return();

}



