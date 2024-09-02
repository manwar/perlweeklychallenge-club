#!/usr/bin/env perl

# Task 2: Relative Sort
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two list of integers, @list1 and @list2. The elements in the @list2 are distinct and also in the @list1.
# Write a script to sort the elements in the @list1 such that the relative order of items in @list1 is same as in the @list2. Elements that is missing in @list2 should be placed at the end of @list1 in ascending order.
# 
# Example 1
# Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
#        @list2 = (2, 1, 4, 3, 5, 6)
# Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)
# 
# Example 2
# Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
#        @list2 = (1, 3, 2)
# Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)
# 
# Example 3
# Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
#        @list2 = (1, 0, 3, 2)
# Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)

use strict;
use warnings;

my @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5);
my @list2 = (2, 1, 4, 3, 5, 6);
relative_sort(\@list1, \@list2);

@list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3);
@list2 = (1, 3, 2);
relative_sort(\@list1, \@list2);

@list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1);
@list2 = (1, 0, 3, 2);
relative_sort(\@list1, \@list2);

exit 0;

sub relative_sort {
    my $list1 = shift;
    my $list2 = shift;

    my %freq;
    foreach my $int (@$list1) {
        $freq{$int}++;
    }

    my @list3;
    foreach my $int (@$list2, sort { $a <=> $b } keys %freq) {
        if ($freq{$int}) {
            push @list3, map { $int }
                            1..$freq{$int};
            delete $freq{$int};
        }
    }

    printf "list1 (%s)\nlist2 (%s)\n\t-> (%s)\n\n",
        (join ', ', @$list1),
        (join ', ', @$list2),
        (join ', ', @list3);
}
