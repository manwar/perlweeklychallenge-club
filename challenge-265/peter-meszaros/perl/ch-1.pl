#!/usr/bin/env perl
#
# You are given an array of integers, @ints.
# 
# Write a script to find an integer in the given array that appeared 33% or
# more. If more than one found, return the smallest. If none found then return
# undef.
# Example 1
# 
# Input: @ints = (1,2,3,3,3,3,4,2)
# Output: 3
# 
# 1 appeared 1 times.
# 2 appeared 2 times.
# 3 appeared 4 times.
# 
# 3 appeared 50% (>33%) in the given array.
# 
# Example 2
# 
# Input: @ints = (1,1)
# Output: 1
# 
# 1 appeared 2 times.
# 
# 1 appeared 100% (>33%) in the given array.
# 
# Example 3
# 
# Input: @ints = (1,2,3)
# Output: 1
# 
# 1 appeared 1 times.
# 2 appeared 1 times.
# 3 appeared 1 times.
# 
# Since all three appeared 33.3% (>33%) in the given array.
# We pick the smallest of all.
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[1, 2, 3, 3, 3, 3, 4, 2], 3, 'Example 1'],
    [[1, 1],                   1, 'Example 2'],
    [[1, 2, 3],                1, 'Example 3'],
    [[],                   undef, 'Example 4'],
];

sub thirtythree_appearance
{
    my $l = shift;
    my $n = shift;

    my %h;
    $h{$_}++ for @$l;
    $h{$_} /= (@$l / 100) for keys %h;
    my @a = sort { $h{$a} == $h{$b} ?  $a <=> $b : $h{$a} <=> $h{$b} }
        grep { $h{$_} > 33 } (keys %h);
    return $a[0];
}

for (@$cases) {
    is(thirtythree_appearance($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
