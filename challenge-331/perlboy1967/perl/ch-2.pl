#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-331#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Buddy Strings
Submitted by: Mohammad Sajid Anwar

You are given two strings, source and target.

Write a script to find out if the given strings are Buddy Strings.

|| If swapping of a letter in one string make them same as the other then
|| they are `Buddy Strings`.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use boolean;
use List::MoreUtils qw(pairwise uniq);


sub areBuddyStrings ($str1,$str2) {
  # The strings must have equal length
  return false if (length($str1) != length($str2));

  # If the strings are identical at least one character
  # must be non uniq
  my @s1 = split //, $str1;
  return true if ($str1 eq $str2 and @s1 > uniq(@s1));

  my @s2 = split //, $str2;

  # Need to have same characters across
  return false if (join('',sort @s1) ne join('',sort @s2));

  # There may be only two characters different position wise
  boolean((grep { $_ != 0 } pairwise { $a cmp $b } @s1,@s2) == 2);
}

is(areBuddyStrings('fuck','fcuk'),true,'Example 1');
is(areBuddyStrings('love','love'),false,'Example 2');
is(areBuddyStrings('fodo','food'),true,'Example 3');
is(areBuddyStrings('feed','feed'),true,'Example 4');
is(areBuddyStrings('PerL','perl'),false,'Own example');

done_testing;
