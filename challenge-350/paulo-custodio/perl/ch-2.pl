#!/usr/bin/env perl

# Challenge 350
#
# Task 2: Shuffle Pairs
# Submitted by: E. Choroba
# If two integers A <= B have the same digits but in different orders, we say that they belong to the same shuffle pair if and only if there is an integer k such that B = A * k where k is called the witness of the pair.
#
# For example, 1359 and 9513 belong to the same shuffle pair, because 1359 * 7 = 9513.
#
# Interestingly, some integers belong to several different shuffle pairs. For example, 123876 forms one shuffle pair with 371628, and another with 867132, as 123876 * 3 = 371628, and 123876 * 7 = 867132.
#
# Write a function that for a given $from, $to, and $count returns the number of integers $i in the range $from <= $i <= $to that belong to at least $count different shuffle pairs.
#
# PS: Inspired by a conversation between Mark Dominus and Simon Tatham at Mastodon.
#
#
# Example 1
# Input: $from = 1, $to = 1000, $count = 1
# Output: 0
#
# There are no shuffle pairs with elements less than 1000.
#
# Example 2
# Input: $from = 1500, $to = 2500, $count = 1
# Output: 3
#
# There are 3 integers between 1500 and 2500 that belong to shuffle pairs.
#
# 1782, the other element is 7128 (witness 4)
# 2178, the other element is 8712 (witness 4)
# 2475, the other element is 7425 (witness 3)
#
# Example 3
# Input: $from = 1_000_000, $to = 1_500_000, $count = 5
# Output: 2
#
# There are 2 integers in the given range that belong to 5 different shuffle pairs.
#
# 1428570 pairs with 2857140, 4285710, 5714280, 7142850, and 8571420
# 1429857 pairs with 2859714, 4289571, 5719428, 7149285, and 8579142
#
# The witnesses are 2, 3, 4, 5, and 6 for both the integers.
#
# Example 4
# Input: $from = 13_427_000, $to = 14_100_000, $count = 2
# Output: 11
#
# 6 integers in the given range belong to 3 different shuffle pairs, 5 integers belong to 2 different ones.
#
# Example 5
# Input: $from = 1030, $to = 1130, $count = 1
# Output: 2
#
# There are 2 integers between 1030 and 1130 that belong to at least one shuffle pair:
# 1035, the other element is 3105 (witness k = 3)
# 1089, the other element is 9801 (witness k = 9)

use Modern::Perl;
use Data::Dump 'dump';

@ARGV==3 or die "usage: $0 from to count\n";
my($from, $to, $count) = @ARGV;

# find shuffle pairs - register A and the number of pairs of A
my %found;
for my $A ($from .. $to) {
    for (my $k = 2; length($A*$k)==length($A); $k++) {
        my $B = $A * $k;
        if (is_shuffle_pair($A, $B)) {
            $found{$A}++;
        }
    }
}

# count how many >= count
my $num = 0;
for (values %found) {
    $num++ if $_ >= $count;
}

say $num;

sub is_shuffle_pair {
    my($a, $b) = @_;
    return unless length($a)==length($b);
    my %count;
    $count{$_}++ for (split //, $a);
    $count{$_}-- for (split //, $b);
    for (values %count) {
        return if $_ != 0;
    }
    return 1;
}
