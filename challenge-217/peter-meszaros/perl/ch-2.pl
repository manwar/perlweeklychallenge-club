#!/usr/bin/env perl
# You are given a list of positive integers.
# 
# Write a script to concatenate the integers to form the highest possible value.
# Example 1:
# 
# Input: @list = (1, 23)
# Output: 231
# 
# Example 2:
# 
# Input: @list = (10, 3, 2)
# Output: 3210
# 
# Example 3:
# 
# Input: @list = (31, 2, 4, 10)
# Output: 431210
# 
# Example 4:
# 
# Input: @list = (5, 11, 4, 1, 2)
# Output: 542111
# 
# Example 5:
# 
# Input: @list = (1, 10)
# Output: 110


use strict;
use warnings;
use Test::More;
use Algorithm::Combinatorics qw/permutations/;

my $cases = [
	[1, 23],          # 0
	[10, 3, 2],       # 1
	[31, 2, 4, 10],   # 2
	[5, 11, 4, 1, 2], # 3
	[1, 10],          # 4
	[4, 41, 4],       # 5
	[4, 48, 6],       # 6
	[64, 84],         # 7
];

sub max_number
{
	my $l = shift;

    my $iter = permutations($l);
    my $r = 0;
    while (my $c = $iter->next) {
		my $v = join('', @$c);
        $r = $v if $v > $r;
	}
    
    return $r;
}

is(max_number($cases->[0]),    231, '[1, 23]');
is(max_number($cases->[1]),   3210, '[10, 3, 2]');
is(max_number($cases->[2]), 431210, '[31, 2, 4, 10]');
is(max_number($cases->[3]), 542111, '[5, 11, 4, 1, 2]');
is(max_number($cases->[4]),    110, '[1, 10]');
is(max_number($cases->[5]),   4441, '[4, 41, 4]');
is(max_number($cases->[6]),   6484, '[4, 48, 6]');
is(max_number($cases->[7]),   8464, '[64, 84]');
done_testing();

exit 0;
