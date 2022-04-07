#!/usr/bin/env perl

# Challenge 040
#
# TASK #2
# Sort SubList
# You are given a list of numbers and set of indices belong to the list.
# Write a script to sort the values belongs to the indices.
#
# For example,
#
# List: [ 10, 4, 1, 8, 12, 3 ]
# Indices: 0,2,5
# We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.
#
# Final List would look like below:
#
# List: [ 1, 4, 3, 8, 12, 10 ]

use Modern::Perl;

my @list = (10, 4, 1, 8, 12, 3);
my @indices = (0,2,5);

@list = sort_sublist(\@list, \@indices);
say "[", join(", ", @list), "]";

sub sort_sublist {
    my($list, $indices) = @_;
    my @list = @$list;
    my @indices = @$indices;
    my @values = sort {$a<=>$b} @list[@indices];
    @list[@indices] = @values;
    return @list;
}
