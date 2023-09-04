#!/usr/bin/env perl

# You are given an array of integers.
# 
# Write a script to sort the given array in increasing order based on the
# frequency of the values. If multiple values have the same frequency then sort
# them in decreasing order.
#
# Example 1
# 
# Input: @ints = (1,1,2,2,2,3)
# Ouput: (3,1,1,2,2,2)
# 
# '3' has a frequency of 1
# '1' has a frequency of 2
# '2' has a frequency of 3
# 
# Example 2
# 
# Input: @ints = (2,3,1,3,2)
# Ouput: (1,3,3,2,2)
# 
# '2' and '3' both have a frequency of 2, so they are sorted in decreasing
# order.
# 
# Example 3
# 
# Input: @ints = (-1,1,-6,4,5,-6,1,4,1)
# Ouput: (5,-1,4,4,-6,-6,1,1,1)
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    [1,1,2,2,2,3],
    [2,3,1,3,2],
    [-1,1,-6,4,5,-6,1,4,1],
];

sub frequency_sort
{
    my $l = shift;
 
    my %h;

	++$h{$_} for @$l;

	my @keylist = sort { if ($h{$a} == $h{$b}) {
							return $b <=> $a;
                         } else {
	                        return $h{$a} <=> $h{$b};
						 }
					   } keys %h;

    my @ret;
	for my $v (@keylist) {
		push @ret, ($v) x $h{$v};
	}

    return \@ret;
}

is_deeply(frequency_sort($cases->[0]), [3,1,1,2,2,2],          '[1,1,2,2,2,3]');
is_deeply(frequency_sort($cases->[1]), [1,3,3,2,2],            '[2,3,1,3,2]');
is_deeply(frequency_sort($cases->[2]), [5,-1,4,4,-6,-6,1,1,1], '[-1,1,-6,4,5,-6,1,4,1]');
done_testing();

exit 0;
