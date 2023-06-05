#!/usr/bin/env perl
# You are given an array of integers, @ints.
# 
#     An array is squareful if the sum of every pair of adjacent elements is a perfect square.
# 
# Write a script to find all the permutations of the given array that are squareful.
# Example 1:
# 
# Input: @ints = (1, 17, 8)
# Output: (1, 8, 17), (17, 8, 1)
# 
# (1, 8, 17) since 1 + 8 => 9, a perfect square and also 8 + 17 => 25 is perfect square too.
# (17, 8, 1) since 17 + 8 => 25, a perfect square and also 8 + 1 => 9 is perfect square too.
# 
# Example 2:
# 
# Input: @ints = (2, 2, 2)
# Output: (2, 2, 2)
# 
# There is only one permutation possible.

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use Math::Combinatorics qw/permute/;
use Digest::SHA qw/sha1/;

my $cases = [
	[1, 17, 8],
	[2, 2, 2],
];

sub uniq_perm
{
	my $p = shift;

    my %h;
    my @r;

	for my $e (@$p) {
		my $k = join('|', @$e);
		++$h{$k};
		push @r, $e if $h{$k} == 1;
	}

	return \@r;
}

sub squareful
{
	my $list = shift;

	my @r;
	my @p = permute(@$list);
	my $p = uniq_perm(\@p);

	for my $l (@$p) {
		my $flag = 1;
		for (my $i=1; $i<@$l; ++$i) {
			my $sqrt = sqrt($l->[$i-1] + $l->[$i]);
			if ($sqrt != int($sqrt)) {
				$flag = 0;
				last;
			}
		}
		push @r, $l if $flag;
	}

    return \@r;
}

is_deeply(squareful($cases->[0]), [[1, 8, 17], [17, 8, 1]], '[1, 17, 8]');
is_deeply(squareful($cases->[1]), [[2, 2, 2]],              '[2, 2, 2]');
done_testing();

exit 0;
