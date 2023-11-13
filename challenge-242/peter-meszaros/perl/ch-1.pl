#!/usr/bin/env perl
#
# You are given two arrays of integers.
# 
# Write a script to find out the missing members in each other arrays.
# Example 1
# 
# Input: @arr1 = (1, 2, 3)
#        @arr2 = (2, 4, 6)
# Output: ([1, 3], [4, 6])
# 
# (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
# (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
# 
# Example 2
# 
# Input: @arr1 = (1, 2, 3, 3)
#        @arr2 = (1, 1, 2, 2)
# Output: ([3])
# 
# (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since
# they are same, keep just one.
# (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
	[[1, 2, 3], [2, 4, 6]],
	[[1, 2, 3, 3], [1, 1, 2, 2]],
];

sub missing_members
{
	my $l1 = $_[0]->[0];
	my $l2 = $_[0]->[1];

    my (%h1, %h2);
	$h1{$_} = 1 for @$l1;
	$h2{$_} = 1 for @$l2;

    --$h2{$_} for @$l1;
    --$h1{$_} for @$l2;

    my $ret = [[], []];

	for (sort keys %h1) {
		push @{$ret->[0]}, $_ if $h1{$_} > 0;
	}
	for (sort keys %h2) {
		push @{$ret->[1]}, $_ if $h2{$_} > 0;
	}

    return $ret;
}

is_deeply(missing_members($cases->[0]), [[1, 3], [4, 6]], '[[1, 2, 3], [2, 4, 6]]');
is_deeply(missing_members($cases->[1]), [[3],[]], '[[1, 2, 3, 3], [1, 1, 2, 2]]');

done_testing();

exit 0;


