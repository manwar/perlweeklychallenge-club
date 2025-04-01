#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-313/#TASK2
#
# Task 2: Reverse Letters
# =======================
#
# You are given a string.
#
# Write a script to reverse only the alphabetic characters in the string.
#
## Example 1
##
## Input: $str = "p-er?l"
## Output: "l-re?p"
#
## Example 2
##
## Input: $str = "wee-k!L-y"
## Output: "yLk-e!e-w"
#
## Example 3
##
## Input: $str = "_c-!h_all-en!g_e"
## Output: "_e-!g_nel-la!h_c"
#
############################################################
##
## discussion
##
############################################################
#
# For each alphabetic character, we take note of the index
# inside the original string and the character itself. However,
# we do this in a way that we have the indices in reversed order.
# Now we can walk both lists in parallel, substituting the
# character at the position of the index for the character in the
# list. Since the indices are reversed, we have everything in the
# order we want in the end.

use v5.36;

reverse_letters( "p-er?l" );
reverse_letters( "wee-k!L-y" );
reverse_letters( "_c-!h_all-en!g_e" );

sub reverse_letters($str) {
   say "Input: \"$str\"";
   my @str = split //, $str;
   my @indices = ();
   my @tmp = ();
   foreach my $i (0..$#str) {
      if($str[$i] =~ m/[a-zA-Z]/) {
         unshift @indices, $i;
         push @tmp, $str[$i];
      }
   }
   foreach my $i (0..$#indices) {
      $str[$indices[$i]] = $tmp[$i];
   }
   say "Output: " . join("", @str);
}
