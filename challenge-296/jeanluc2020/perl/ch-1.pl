#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-296/#TASK1
#
# Task 1: String Compression
# ==========================
#
# You are given a string of alphabetic characters, $chars.
#
# Write a script to compress the string with run-length encoding, as shown in
# the examples.
#
# A compressed unit can be either a single character or a count followed by a
# character.
#
# BONUS: Write a decompression function.
#
## Example 1
##
## Input: $chars = "abbc"
## Output: "a2bc"
#
## Example 2
##
## Input: $chars = "aaabccc"
## Output: "3ab3c"
#
## Example 3
##
## Input: $chars = "abcc"
## Output: "ab2c"
#
############################################################
##
## discussion
##
############################################################
#
# For compression, we count the same character. If another character
# comes up, we either have more than one, which we replace by the
# number and the character, or we have exactly one which we just add
# to the end.
# For decompression, if there is a number at the beginning of the string,
# we just take it as the count (otherwise we take 1 as the count), and
# multiply the next character accordingly.
use strict;
use warnings;

foreach my $string ( ("abbc", "aaabccc", "abcc") ) {
   print "Input: $string\n";
   my $compressed = string_compression($string);
   print "Output: $compressed\n";
   print "Uncompressed: " . string_decompression($compressed) . "\n";
}

sub string_compression {
   my $chars = shift;
   my $count = 1;
   my ($prev, @rest) = split //, $chars;
   my $result = "";
   while(@rest) {
      my $next = shift @rest;
      if($next eq $prev) {
         $count++;
      } else {
         if($count > 1) {
            $result .= "$count$prev";
            $count = 1;
         } else {
            $result .= $prev;
         }
         $prev = $next;
      }
   }
   if($count > 1) {
      $result .= $count;
   }
   $result .= $prev;
   return $result;
}

sub string_decompression {
   my $input = shift;
   my $result = "";
   my $count;
   while(length($input)) {
      $count = 1;
      if($input =~ m/^\d/) {
         $input =~ s/(\d+)//;
         $count = $1;
      }
      $input =~ s/^(.)//;
      my $char = $1;
      $result .= $char x $count;
   }
   return $result;
}
