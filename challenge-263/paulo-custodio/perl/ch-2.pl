#!/usr/bin/env perl

# Challenge 263
#
# Task 2: Merge Items
# Submitted by: Mohammad Sajid Anwar
#
# You are given two 2-D array of positive integers, $items1 and $items2 where
# element is pair of (item_id, item_quantity).
#
# Write a script to return the merged items.
# Example 1
#
# Input: $items1 = [ [1,1], [2,1], [3,2] ]
#        $items2 = [ [2,2], [1,3] ]
# Output: [ [1,4], [2,3], [3,2] ]
#
# Item id (1) appears 2 times: [1,1] and [1,3]. Merged item now (1,4)
# Item id (2) appears 2 times: [2,1] and [2,2]. Merged item now (2,3)
# Item id (3) appears 1 time: [3,2]
#
# Example 2
#
# Input: $items1 = [ [1,2], [2,3], [1,3], [3,2] ]
#        $items2 = [ [3,1], [1,3] ]
# Output: [ [1,8], [2,3], [3,3] ]
#
# Example 3
#
# Input: $items1 = [ [1,1], [2,2], [3,3] ]
#        $items2 = [ [2,3], [2,4] ]
# Output: [ [1,1], [2,9], [3,3] ]

use Modern::Perl;
use List::Util qw( uniq pairs );

my($items1, $items2) = split /,/, "@ARGV";
my @items1 = (split ' ', $items1);
my @items2 = (split ' ', $items2);

my %items;
for (pairs(@items1, @items2)) {
    my($k, $v) = @$_;
    $items{$k} += $v;
}

my @result;
for my $k (sort {$a <=> $b} keys %items) {
    push @result, $k." ".$items{$k};
}
say join "   ", @result;
