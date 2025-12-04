#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/#TASK2
#
# Task 2: Shuffle Pairs
# =====================
#
# If two integers A <= B have the same digits but in different orders, we say
# that they belong to the same shuffle pair if and only if there is an integer
# k such that B = A * k where k is called the witness of the pair.
#
# For example, 1359 and 9513 belong to the same shuffle pair, because 1359 * 7 = 9513.
#
# Interestingly, some integers belong to several different shuffle pairs. For
# example, 123876 forms one shuffle pair with 371628, and another with 867132,
# as 123876 * 3 = 371628, and 123876 * 7 = 867132.
#
# Write a function that for a given $from, $to, and $count returns the number
# of integers $i in the range $from <= $i <= $to that belong to at least $count
# different shuffle pairs.
#
# PS: Inspired by a conversation between Mark Dominus and Simon Tatham at Mastodon.
#
## Example 1
##
## Input: $from = 1, $to = 1000, $count = 1
## Output: 0
##
## There are no shuffle pairs with elements less than 1000.
#
#
## Example 2
##
## Input: $from = 1500, $to = 2500, $count = 1
## Output: 3
##
## There are 3 integers between 1500 and 2500 that belong to shuffle pairs.
##
## 1782, the other element is 7128 (witness 4)
## 2178, the other element is 8712 (witness 4)
## 2475, the other element is 7425 (witness 3)
#
#
## Example 3
##
## Input: $from = 1_000_000, $to = 1_500_000, $count = 5
## Output: 2
##
## There are 2 integers in the given range that belong to 5 different shuffle
## pairs.
##
## 1428570 pairs with 2857140, 4285710, 5714280, 7142850, and 8571420
## 1429857 pairs with 2859714, 4289571, 5719428, 7149285, and 8579142
##
## The witnesses are 2, 3, 4, 5, and 6 for both the integers.
#
#
## Example 4
##
## Input: $from = 13_427_000, $to = 14_100_000, $count = 2
## Output: 11
##
## 6 integers in the given range belong to 3 different shuffle pairs, 5
## integers belong to 2 different ones.
#
#
## Example 5
##
## Input: $from = 1030, $to = 1130, $count = 1
## Output: 2
##
## There are 2 integers between 1030 and 1130 that belong to at least one shuffle pair:
## 1035, the other element is 3105 (witness k = 3)
## 1089, the other element is 9801 (witness k = 9)
#
############################################################
##
## discussion
##
############################################################
#
# We start by noting that a number can only have shuffle pairs with witnesses
# in the range 2..9.
# However, this can go both ways: 1359 pairs with 9513, so in case the range is
# 1000..1500, we need to find this pair, but we also need to find it if the
# range is 9000..9600 (and we need to find both the numbers as part of a shuffle
# pair if the range is 1000..9600).
# So for each number in the range, we check whether we have the required number
# of pairs by checking in both directions - which means both multiplying and
# dividing by 2..9.
# We can stop searching for more witnesses once we found enough witnesses for
# our given count.
#
use v5.36;

shuffle_pairs(1, 1000, 1);
shuffle_pairs(1500, 2500, 1);
shuffle_pairs(1_000_000, 1_500_000, 5);
shuffle_pairs(13_427_000, 14_100_000, 2);
shuffle_pairs(1030, 1130, 1);

sub shuffle_pairs($from, $to, $count) {
    say "Input: $from, $to, $count";
    my $output = 0;
    foreach my $i ($from..$to) {
        $output++ if enough_pairs($i, $count);
    }
    say "Output: $output";
}

sub enough_pairs($number, $required_count) {
    my $count = 0;
    foreach my $x (2..9) {
        $count++ if is_pair($number, $number * $x);
        $count++ if is_pair($number, $number / $x);
        last if $count >= $required_count;
    }
    return $count >= $required_count;
}

sub is_pair($i, $j) {
    return 0 unless $j == int($j);
    my $left = join("", sort {$a <=> $b} split //,$i);
    my $right = join("", sort {$a <=> $b} split //,$j);
    return $left eq $right;
}
