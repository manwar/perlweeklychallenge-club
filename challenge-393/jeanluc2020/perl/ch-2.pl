#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-393/#TASK2
#
# Task 2: Prime Step
# ==================
#
# You are given a string with English alphabetic characters only.
#
# What is the absolute difference of the sum of the ASCII values of the
# characters in the string to the nearest prime number?
#
## Example 1
##
## Input: $str = "hello"
## Output: 9
##
## The ordinal values of "hello" are [104,101,108,108,111], summing up to 532.
## The nearest prime number to 532 is 523, resulting in an absolute difference of 9.
#
## Example 2
##
## Input: $str = "football"
## Output: 2
##
## Starting with the values [102,111,111,116,98,97,108,108] and the sum 841.
## We find 839 as the nearest prime number, so the difference is 2.
#
## Example 3
##
## Input: $str = "a"
## Output: 0
#
## Example 4
##
## Input: $str = "challenge"
## Output: 2
##
## The ordinal values of "challenge" are [99, 104, 97, 108, 108, 101, 110, 103, 101], which sum up to 931.
## The nearest prime number to 931 is 929, so the difference is 2.
#
## Example 5
##
## Input: $str = "perl"
## Output: 2
##
## The ordinal values of "perl" are [112, 101, 114, 108], summing up to 435.
## Nearest prime is 433, so the difference is 2.
#
############################################################
##
## discussion
##
############################################################
#
# First, we calculate the sum by applying ord() to all letters in the input.
# Then, we check all numbers up to this number for primes and keep note of
# the biggest one, plus all numbers bigger than the sum until we find the next
# prime (of course we jump out of the whole loop if the sum happens to be a
# prime since then we can just return 0). Of the differences from the sum
# to both the biggest prime smaller than the input and the next prime after it,
# we pick the smaller one for the result.

use v5.36;

prime_step("hello");
prime_step("football");
prime_step("a");
prime_step("challenge");
prime_step("perl");

sub prime_step($str) {
    say "Input: \"$str\"";
    my $sum = 0;
    map { $sum += ord($_) } split //, $str;
    say "-> $sum";
    my ($smaller, $bigger) = (0, 0);
    my $i = 0;
    while($i <= $sum or not is_prime($i)) {
        $i++;
        # print "$i... ";
        if($i < $sum and is_prime($i)) {
            $smaller = $i;
        }
        if($i == $sum and is_prime($i)) {
            return say "Output: 0";
        }
        if($i > $sum and is_prime($i)) {
            $bigger = $i;
        }
    }
    my $d1 = $sum - $smaller;
    my $d2 = $bigger - $sum;

    if($d1 > $d2) {
        say "Output: $d2";
    } else {
        say "Output: $d1";
    }
}


# We keep a cache of entries for everything we already calculated
# so we don't need to recalculate whether any number happens to be
# a prime multiple times.
{
   my $cache;
   sub is_prime {
      my $num = shift;
      return 0 if $num == 1;
      return $cache->{$num} if defined $cache->{$num};
      my $divider = 2;
      while($divider <= sqrt($num)) {
         if(int($num/$divider) == $num/$divider) {
            $cache->{$num} = 0;
            return 0;
         }
         $divider++;
      }
      $cache->{$num} = 1;
      return 1;
   }
}
