#!/usr/bin/perl
# Example 1
# 
# Input: @list = (1,2,3,4,5,6)
# Output: (2,4,6,1,3,5)
# 
# Example 2
# 
# Input: @list = (1,2)
# Output: (2,1)
# 
# Example 3
# 
# Input: @list = (1)
# Output: (1)

use strict;
use warnings;
use Test::More;

my $cases = [
	[1, 2, 3, 4, 5, 6],
	[1, 2],
	[1],
];

sub odd_even_sort   
{
    my $aref = shift;

    my @sorted = sort {
        my $aodd = $a % 2;
        my $bodd = $b % 2;
		if ($aodd and !$bodd) {
			return 1;
		} elsif ($bodd and !$aodd) {
			return -1;
        } else  {
			return $a <=> $b;
        }
	} @$aref;
    return \@sorted;
}

is_deeply(odd_even_sort($cases->[0]), [2,4,6,1,3,5], '[2,4,6,1,3,5]');
is_deeply(odd_even_sort($cases->[1]), [2,1],         '[2,1]');
is_deeply(odd_even_sort($cases->[2]), [1],           '[1]');
done_testing();

exit 0;
