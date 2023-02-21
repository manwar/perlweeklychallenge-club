#!/usr/bin/env perl

# Task 2: Maximum XOR
# Submitted by: Mohammad S Anwar
# 
# You are given an array of integers.
# Write a script to find the highest value obtained by XORing any two distinct members of the array.
#
# Example 1
# Input: @array = (1,2,3,4,5,6,7)
# Output: 7
# 
# The maximum result of 1 xor 6 = 7.
# 
# Example 2
# Input: @array = (2,4,1,3)
# Output: 7
# 
# The maximum result of 4 xor 3 = 7.
# 
# Example 3
# Input: @array = (10,5,7,12,8)
# Output: 15
# 
# The maximum result of 10 xor 5 = 15.


use strict;
use warnings;
use Math::Combinatorics;
 
my @input = @ARGV;
die "Input error\n"
    if scalar @input < 2
       or
       (scalar map { $_ =~ /^\d+$/ ? () : 1 }
                @input) != 0;
my $combinat = Math::Combinatorics->new(count => 2,
                                        data => [map {int} @input],
                                       );
my %max;
while (my @pair = $combinat->next_combination) {
    if (!defined($max{val}) or 
        ($pair[0] ^ $pair[1]) > $max{val}
    ) {
        $max{val} = $pair[0] ^ $pair[1];
        $max{pair} = \@pair;
    }
}

printf "Output: %d\n", $max{val};
printf "The maximum result of %d xor %d = %d\n", $max{pair}->[0], $max{pair}->[1], $max{val};
