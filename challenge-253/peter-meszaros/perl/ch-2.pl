#!/usr/bin/env perl
#
# You are given an m x n binary matrix i.e. only 0 and 1 where 1 always appear
# before 0.
# 
# A row i is weaker than a row j if one of the following is true:
# 
# a) The number of 1s in row i is less than the number of 1s in row j.
# b) Both rows have the same number of 1 and i < j.
# 
# Write a script to return the order of rows from weakest to strongest.
# Example 1
# 
# Input: $matrix = [
#                    [1, 1, 0, 0, 0],
#                    [1, 1, 1, 1, 0],
#                    [1, 0, 0, 0, 0],
#                    [1, 1, 0, 0, 0],
#                    [1, 1, 1, 1, 1]
#                  ]
# Output: (2, 0, 3, 1, 4)
# 
# The number of 1s in each row is:
# - Row 0: 2
# - Row 1: 4
# - Row 2: 1
# - Row 3: 2
# - Row 4: 5
# 
# Example 2
# 
# Input: $matrix = [
#                    [1, 0, 0, 0],
#                    [1, 1, 1, 1],
#                    [1, 0, 0, 0],
#                    [1, 0, 0, 0]
#                  ]
# Output: (0, 2, 3, 1)
# 
# The number of 1s in each row is:
# - Row 0: 1
# - Row 1: 4
# - Row 2: 1
# - Row 3: 1
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use List::Util qw/sum/;

my $cases = [
	[
		[1, 1, 0, 0, 0],
		[1, 1, 1, 1, 0],
		[1, 0, 0, 0, 0],
		[1, 1, 0, 0, 0],
		[1, 1, 1, 1, 1],
	],
	[
		[1, 0, 0, 0],
		[1, 1, 1, 1],
		[1, 0, 0, 0],
		[1, 0, 0, 0],
	]
];

sub weakest_row
{
	my $m = shift;

    my %h;
	for my $i (0..$#$m) {
		$h{$i} = sum($m->[$i]->@*);
	}
    
    my @res = sort {
					$h{$a} == $h{$b} ? $a <=> $b : $h{$a} <=> $h{$b}
                   } keys %h;
    return \@res;
}

is(weakest_row($cases->[0]), [2, 0, 3, 1, 4], 'Example 1');
is(weakest_row($cases->[1]), [0, 2, 3, 1],    'Example 2');
done_testing();

exit 0;

         
