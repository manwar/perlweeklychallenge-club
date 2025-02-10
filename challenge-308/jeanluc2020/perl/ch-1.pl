#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-308/#TASK1
#
# Task 1: Count Common
# ====================
#
# You are given two array of strings, @str1 and @str2.
#
# Write a script to return the count of common strings in both arrays.
#
## Example 1
##
## Input: @str1 = ("perl", "weekly", "challenge")
##        @str2 = ("raku", "weekly", "challenge")
## Output: 2
#
## Example 2
##
## Input: @str1 = ("perl", "raku", "python")
##        @str2 = ("python", "java")
## Output: 1
#
## Example 3
##
## Input: @str1 = ("guest", "contribution")
##        @str2 = ("fun", "weekly", "challenge")
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# Let's make sure that both arrays don't have duplicate entries. Then
# we can count all occurrences for all elements, which is either 1 or 2.
# In the latter case, we can add 1 to our result.

use v5.36;
use List::Util qw(uniq);

count_common( ["perl", "weekly", "challenge"], ["raku", "weekly", "challenge"]);
count_common( ["perl", "raku", "python"], ["python", "java"] );
count_common( ["guest", "contribution"], ["fun", "weekly", "challenge"] );

sub count_common {
   my ($str1, $str2) = @_;
   print "Input: (" . join(", ", @$str1) . "), (" . join(", ", @$str2) . ")\n";
   my @str1 = uniq(@$str1);
   my @str2 = uniq(@$str2);
   my $tmp;
   my $result = 0;
   foreach my $elem ( (@str1, @str2) ) {
      $tmp->{$elem}++;
      if($tmp->{$elem} > 1) {
         $result++;
      }
   }
   print "Output: $result\n";
}
