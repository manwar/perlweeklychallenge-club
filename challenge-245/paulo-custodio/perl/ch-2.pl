#!/usr/bin/env perl

# Challenge 245
#
# Task 2: Largest of Three
# Submitted by: Mohammad S Anwar
#
# You are given an array of integers >= 0.
#
# Write a script to return the largest number formed by concatenating some of
# the given integers in any order which is also multiple of 3. Return -1 if
# none found.
#
# Example 1
#
# Input: @ints = (8, 1, 9)
# Output: 981
#
# 981 % 3 == 0
#
# Example 2
#
# Input: @ints = (8, 6, 7, 1, 0)
# Output: 8760
#
# Example 3
#
# Input: @ints = (1)
# Output: -1

use Modern::Perl;

sub largest {
    my($prefix, @nums) = @_;

    my $largest = -1;
    $prefix =~ s/^0+(\d)/$1/;
    if (length($prefix) > 0) {
        if ($prefix % 3 == 0) {
            $largest = $prefix if $prefix > $largest;
        }
    }

    for my $i (0 .. $#nums) {
        my $new = largest($prefix.$nums[$i],
                          @nums[0..$i-1], @nums[$i+1..$#nums]);
        $largest = $new if $new > $largest;
    }

    return $largest;
}

@ARGV or die "Usage: $0 n n n...\n";
my @nums = @ARGV;
say largest('', @nums);
