#!/usr/bin/env perl
#
# You are given two arrays of integers, @source and @indices. The @indices can
# only contains integers 0 <= i < size of @source.
# 
# Write a script to create target array by insert at index $indices[i] the
# value $source[i].
# Example 1
# 
# Input: @source  = (0, 1, 2, 3, 4)
#        @indices = (0, 1, 2, 2, 1)
# Output: (0, 4, 1, 3, 2)
# 
# @source  @indices  @target
# 0        0         (0)
# 1        1         (0, 1)
# 2        2         (0, 1, 2)
# 3        2         (0, 1, 3, 2)
# 4        1         (0, 4, 1, 3, 2)
# 
# Example 2
# Input: @source  = (1, 2, 3, 4, 0)
#        @indices = (0, 1, 2, 3, 0)
# Output: (0, 1, 2, 3, 4)
# 
# @source  @indices  @target
# 1        0         (1)
# 2        1         (1, 2)
# 3        2         (1, 2, 3)
# 4        3         (1, 2, 3, 4)
# 0        0         (0, 1, 2, 3, 4)
# 
# Example 3
# 
# Input: @source  = (1)
#        @indices = (0)
# Output: (1)
#

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[[0, 1, 2, 3, 4], [0, 1, 2, 2, 1]], [0, 4, 1, 3, 2], 'Example 1'],
    [[[1, 2, 3, 4, 0], [0, 1, 2, 3, 0]], [0, 1, 2, 3, 4], 'Example 2'],
    [[[1],             [0]],             [1],             'Example 3'],
];

sub target_array
{
    my $sources = $_[0]->[0];
    my $indices = $_[0]->[1];

    my @res;
    splice @res, $indices->[$_], 0, $sources->[$_] for 0..$#$sources;

    return \@res;
}

for (@$cases) {
    is(target_array($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;

