#!/usr/bin/env perl
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
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[[[[1,1], [2,1], [3,2]],        [[2,2], [1,3]]],
	 [[1,4], [2,3], [3,2]], 'Example 1'],
	[[[[1,2], [2,3], [1,3], [3,2]], [[3,1], [1,3]]],
     [[1,8], [2,3], [3,3]], 'Example 2'],
	[[[[1,1], [2,2], [3,3]],        [[2,3], [2,4]]],
     [[1,1], [2,9], [3,3]], 'Example 3'],
];

sub merge_items
{
    my $l1 = $_->[0]->[0];
    my $l2 = $_->[0]->[1];

    my %l;

    for my $i (@$l1, @$l2) {
        $l{$i->[0]} += $i->[1];
    }

    my @res;
    for my $k (sort {$a <=> $b} keys %l) {
        push @res, [$k, $l{$k}];
    }

    return \@res;
}

for (@$cases) {
    is(merge_items($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

