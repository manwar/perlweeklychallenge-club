#!/usr/bin/env perl
#
# You are given an array of integers.
# 
# Write a script to duplicate each occurrence of ZERO in the given array and
# shift the remaining to the right but make sure the size of array remain the
# same.
# Example 1
# 
# Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
# Ouput: (1, 0, 0, 2, 3, 0, 0, 4)
# 
# Example 2
# 
# Input: @ints = (1, 2, 3)
# Ouput: (1, 2, 3)
# 
# Example 3
# 
# Input: @ints = (0, 3, 0, 4, 5)
# Ouput: (0, 0, 3, 0, 0)
# 

use strict;
use warnings;
use Test::More;
use Data::Dumper;

my $cases = [
    [1, 0, 2, 3, 0, 4, 5, 0],
    [1, 2, 3],
    [0, 3, 0, 4, 5],
];

sub duplicate_zeros
{
	my $l = shift;
    
    my $len = @$l - 1;
    my @res = map { $_ == 0 ? qw/0 0/ : $_} @$l;
	@res = @res[0 .. $len];
	return \@res;
}

is_deeply(duplicate_zeros($cases->[0]), [1, 0, 0, 2, 3, 0, 0, 4], '[1, 0, 2, 3, 0, 4, 5, 0]');
is_deeply(duplicate_zeros($cases->[1]), [1, 2, 3],                '[1, 2, 3]');
is_deeply(duplicate_zeros($cases->[2]), [0, 0, 3, 0, 0],          '[0, 3, 0, 4, 5]');
done_testing();

exit 0;
