#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-278/#TASK2
#
# Task 2: Reverse Word
# ====================
#
# You are given a word, $word and a character, $char.
#
# Write a script to replace the substring up to and including $char with its
# characters sorted alphabetically. If the $char doesn’t exist then DON'T do
# anything.
#
## Example 1
##
## Input: $str = "challenge", $char = "e"
## Ouput: "acehllnge"
#
## Example 2
##
## Input: $str = "programming", $char = "a"
## Ouput: "agoprrmming"
#
## Example 3
##
## Input: $str = "champion", $char = "b"
## Ouput: "champion"
#
############################################################
##
## discussion
##
############################################################
#
# If $str matches $char, we split $str into two pieces at $char,
# then we split the prefix part plus $char into single characters,
# sort those and join them together as the new prefix to which we
# append the postfix part.

use strict;
use warnings;

reverse_word("challenge", "e");
reverse_word("programming", "a");
reverse_word("champion", "b");

sub reverse_word {
   my ($str, $char) = @_;
   print "Input: \"$str\"\n";
   if($str =~ m/$char/) {
      my ($prefix, $postfix) = split /$char/, $str, 2;
      $str = join("", sort split //, "$prefix$char") . $postfix;
   }
   print "Output: \"$str\"\n";
}
