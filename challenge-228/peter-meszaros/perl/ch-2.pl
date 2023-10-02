#!/usr/bin/env perl

# You are given an array of integers in which all elements are unique.
# 
# Write a script to perform the following operations until the array is empty and
# return the total count of operations.
# 
# If the first element is the smallest then remove it otherwise move it to the
# end.
# 
# 
# Example 1
# 
# Input: @int = (3, 4, 2)
# Ouput: 5
# 
# Operation 1: move 3 to the end: (4, 2, 3)
# Operation 2: move 4 to the end: (2, 3, 4)
# Operation 3: remove element 2: (3, 4)
# Operation 4: remove element 3: (4)
# Operation 5: remove element 4: ()
# 
# Example 2
# 
# Input: @int = (1, 2, 3)
# Ouput: 3
# 
# Operation 1: remove element 1: (2, 3)
# Operation 2: remove element 2: (3)
# Operation 3: remove element 3: ()

use strict;
use warnings;
use List::Util qw/min/;
use Test::More;
use Data::Dumper;

my $cases = [
    [3, 4, 2],
    [1, 2, 3],
];

sub empty_array
{
	my @a = $_[0]->@*;

	my $numop = 0;
    while (@a) {
		if (min(@a) < $a[0]) {
			push @a, $a[0];
		}
		shift @a;
		++$numop;
		
	}
    return $numop;
}

is(empty_array($cases->[0]), 5, '[3, 4, 2]');
is(empty_array($cases->[1]), 3, '[1, 2, 3]');
done_testing();

exit 0;
