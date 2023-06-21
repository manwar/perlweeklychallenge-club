#!/usr/bin/env perl

# You are given an array of positive integers, @ints.
# 
# Write a script to find the last member if found otherwise return 0. Each turn
# pick 2 biggest members (x, y) then decide based on the following conditions,
# continue this until you are left with 1 member or none.
# 
#     a) if x == y then remove both members
# 
#     b) if x != y then remove both members and add new member (y-x)
# 
# 
# Example 1:
# 
# Input: @ints = (2, 7, 4, 1, 8, 1)
# Output: 1
# 
# Step 1: pick 7 and 8, we remove both and add new member 1 => (2, 4, 1, 1, 1).
# Step 2: pick 2 and 4, we remove both and add new member 2 => (2, 1, 1, 1).
# Step 3: pick 2 and 1, we remove both and add new member 1 => (1, 1, 1).
# Step 4: pick 1 and 1, we remove both => (1).
# 
# Example 2:
# 
# Input: @ints = (1)
# Output: 1
# 
# Example 3:
# 
# Input: @ints = (1, 1)
# Output: 0
# 
# Step 1: pick 1 and 1, we remove both and we left with none.

use strict;
use warnings;
use Test::More;
use Data::Dumper;
use Math::Combinatorics qw/permute/;
use Digest::SHA qw/sha1/;

my $cases = [
    [2, 7, 4, 1, 8, 1],
    [1],
    [1, 1],
];

sub get_2_biggest
{
    my $l = shift;
    my @ls = sort {$b <=> $a} @$l;
    my @ret;

    for (my $i=0; $i<@$l; ++$i) {
        if ($l->[$i] == $ls[0]) {
            push @ret, $i;
            last if @ret == 2;
        }
        if ($l->[$i] == $ls[1]) {
            push @ret, $i;
            last if @ret == 2;
        }
    }

    return @ret;
}

sub last_member
{
    my $l = shift;

    my $len = @$l;

    while (@$l > 1) {
        my ($i1, $i2) = get_2_biggest($l);
        my $diff = abs($l->[$i2] - $l->[$i1]);
        push @$l, $diff if $diff;
        splice(@$l, $i1 > $i2 ? $i1 : $i2, 1);
        splice(@$l, $i1 < $i2 ? $i1 : $i2, 1);
        $len = @$l;
    }

    return scalar @$l;
}

is(last_member($cases->[0]), 1, '[2, 7, 4, 1, 8, 1]');
is(last_member($cases->[1]), 1, '[1]');
is(last_member($cases->[2]), 0, '[1, 1]');
done_testing();

exit 0;
