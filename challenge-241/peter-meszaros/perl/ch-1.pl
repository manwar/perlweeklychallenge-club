#!/usr/bin/env perl
#
# You are given an array (3 or more members) of integers in increasing order
# and a positive integer.
# 
# Write a script to find out the number of unique Arithmetic Triplets
# satisfying the following rules:
# 
# a) i < j < k
# b) nums[j] - nums[i] == diff
# c) nums[k] - nums[j] == diff
# 
# Example 1
# 
# Input: @nums = (0, 1, 4, 6, 7, 10)
#        $diff = 3
# Output: 2
# 
# Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3.
# Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3.
# 
# Example 2
# 
# Input: @nums = (4, 5, 6, 7, 8, 9)
#        $diff = 2
# Output: 2
# 
# (0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
# (1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.
# 

use strict;
use warnings;
use feature qw/fc/;
use Test::More;
use Data::Dumper;

my $cases = [
    [[0, 1, 4, 6, 7, 10], 3],
    [[4, 5, 6, 7, 8, 9], 2],
];

sub arithmetic_triplets
{
    my @l = $_[0]->[0]->@*;
    my $d = $_[0]->[1];

	my $cnt = 0;
    for my $i (1..($#l-1)) {
        for my $l (0..($i-1)) {
            for my $g (($i+1)..$#l) {
                my $d1 = $l[$i] - $l[$l];
				my $d2 = $l[$g] - $l[$i];
                if ($d1 == $d && $d2 == $d) {
					++$cnt;
                }
            }
        }
    }

    return $cnt;
}

is(arithmetic_triplets($cases->[0]), 2, '[[0, 1, 4, 6, 7, 10], 3]');
is(arithmetic_triplets($cases->[1]), 2, '[[4, 5, 6, 7, 8, 9], 2]');
done_testing();

exit 0;


