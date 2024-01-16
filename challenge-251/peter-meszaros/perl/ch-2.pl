#!/usr/bin/env perl
#
# You are given a m x n matrix of distinct numbers.
# 
# Write a script to return the lucky number, if there is one, or -1 if not.
# 
# A lucky number is an element of the matrix such that it is
# the minimum element in its row and maximum in its column.
# 
# Example 1
# 
# Input: $matrix = [ [ 3,  7,  8],
#                    [ 9, 11, 13],
#                    [15, 16, 17] ];
# Output: 15
# 
# 15 is the only lucky number since it is the minimum in its row
# and the maximum in its column.
# 
# Example 2
# 
# Input: $matrix = [ [ 1, 10,  4,  2],
#                    [ 9,  3,  8,  7],
#                    [15, 16, 17, 12] ];
# Output: 12
# 
# Example 3
# 
# Input: $matrix = [ [7 ,8],
#                    [1 ,2] ];
# Output: 7
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/min/;

my $cases = [
	[[ 3,  7,  8],
	 [ 9, 11, 13],
	 [15, 16, 17]],
	[[ 1, 10,  4,  2],
	 [ 9,  3,  8,  7],
	 [15, 16, 17, 12]],
	[[7 ,8],
	 [1 ,2]],
];

sub lucky_numbers
{
	my $l = shift;

    my (@rowmin, @colmax);
	for my $row (@$l) {
        push @rowmin, min $row->@*;
        for my $i (0..$#$row) {
            $colmax[$i]  = $row->[$i] if ($colmax[$i] // 0) < $row->[$i];
        }
	}

	my $lucky = -1;
    my %hash = map {$_ => 1} @rowmin;
    for my $v (@colmax) {
        if (exists $hash{$v}) {
            $lucky = $v;
            last;
        }
        $hash{$v}++;
    }

	return $lucky;
}

is(lucky_numbers($cases->[0]), 15, 'Example 1');
is(lucky_numbers($cases->[1]), 12, 'Example 2');
is(lucky_numbers($cases->[2]),  7, 'Example 3');
done_testing();

exit 0;

         
