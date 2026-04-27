#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-371/#TASK2
#
# Task 2: Subset Equilibrium
# ==========================
#
# You are given an array of numbers.
#
# Write a script to find all proper subsets with more than one element where
# the sum of elements equals the sum of their indices.
#
## Example 1
##
## Input: @nums = (2, 1, 4, 3)
## Output: (2, 1), (1, 4), (4, 3), (2, 3)
##
## Subset 1: (2, 1)
## Values: 2 + 1 = 3
## Positions: 1 + 2 = 3
##
## Subset 2: (1, 4)
## Values: 1 + 4 = 5
## Positions: 2 + 3 = 5
##
## Subset 3: (4, 3)
## Values: 4 + 3 = 7
## Positions: 3 + 4 = 7
##
## Subset 4: (2, 3)
## Values: 2 + 3 = 5
## Positions: 1 + 4 = 5
#
## Example 2
##
## Input: @nums = (3, 0, 3, 0)
## Output: (3, 0), (3, 0, 3)
##
## Subset 1: (3, 0)
## Values: 3 + 0 = 3
## Positions: 1 + 2 = 3
##
## Subset 2: (3, 0, 3)
## Values: 3 + 0 + 3 = 6
## Positions: 1 + 2 + 3 = 6
#
## Example 3
##
## Input: @nums = (5, 1, 1, 1)
## Output: (5, 1, 1)
##
## Subset 1: (5, 1, 1)
## Values: 5 + 1 + 1 = 7
## Positions: 1 + 2 + 4 = 7
#
## Example 4
##
## Input: @nums = (3, -1, 4, 2)
## Output: (3, 2), (3, -1, 4)
##
## Subset 1: (3, 2)
## Values: 3 + 2 = 5
## Positions: 1 + 4 = 5
##
## Subset 2: (3, -1, 4)
## Values: 3 + (-1) + 4 = 6
## Positions: 1 + 2 + 3 = 6
#
## Example 5
##
## Input: @nums = (10, 20, 30, 40)
## Output: ()
#
############################################################
##
## discussion
##
############################################################
#
# We create all a temporary array with all elements from @nums
# with their index appended after ":". That way, we can just
# create all possible subsets by using Data::PowerSet's
# powerset(). From the powerset, we discard the empty set as
# well as all sets with only one element and the set that
# contains all elements (as it is not a proper subset). We also
# discard all non-matching subsets, with non-matching being the
# ones where the sum of the elements and the sum of the indices
# don't match (we us a little helper function to determine that).

use v5.36;
use Data::PowerSet qw(powerset);

subset_equilibrium(2, 1, 4, 3);
subset_equilibrium(3, 0, 3, 0);
subset_equilibrium(5, 1, 1, 1);
subset_equilibrium(3, -1, 4, 2);
subset_equilibrium(10, 20, 30, 40);

sub subset_equilibrium(@nums) {
    say "Input: (" . join(", ", @nums) . ")";
    my $subsets = generate_subsets(@nums);
    my @result = ();
    foreach my $subset (@$subsets) {
        next unless @$subset;
        next unless is_matching($subset);
        next if scalar(@$subset) == scalar(@nums); # all elements != proper subset
        next if scalar(@$subset) <= 1; # not more than one element: discard
        my @tmp = ();
        foreach my $elem (@$subset) {
            $elem =~ s/:.*//;
            push @tmp, $elem;
        }
        push @result, [ @tmp ];
    }
    print "Output: (";
    foreach my $elem (@result) {
        print "[" . join(", ", @$elem) . "], "
    }
    say ")";
}

sub is_matching($subset) {
    my @elems = @$subset;
    my $sum_elems = 0;
    my $sum_index = 0;
    foreach my $elem (@elems) {
        my ($e, $i) = split /:/, $elem;
        $sum_elems += $e;
        $sum_index += $i;
    }
    return $sum_elems == $sum_index;
}

sub generate_subsets(@elems) {
    my @tmp = ();
    foreach my $i (1..$#elems+1) {
        push @tmp, "$elems[$i-1]:$i";
    }
    return powerset(@tmp);
}
