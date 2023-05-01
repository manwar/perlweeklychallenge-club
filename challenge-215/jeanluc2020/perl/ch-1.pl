#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-215/#TASK1
#
# Task 1: Odd one Out
# ===================
#
# You are given a list of words (alphabetic characters only) of same size.
#
# Write a script to remove all words not sorted alphabetically and print the
# number of words in the list that are not alphabetically sorted.
#
## Example 1
##
## Input: @words = ('abc', 'xyz', 'tsu')
## Output: 1
##
## The words 'abc' and 'xyz' are sorted and can't be removed.
## The word 'tsu' is not sorted and hence can be removed.
#
## Example 2
##
## Input: @words = ('rat', 'cab', 'dad')
## Output: 3
##
## None of the words in the given list are sorted.
## Therefore all three needs to be removed.
#
## Example 3
##
## Input: @words = ('x', 'y', 'z')
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# We look at each word in the list. If it's sorted, we keep it.
# At the end, the amount of removed words is the difference
# in length of the original list and the "keep" list.

use strict;
use warnings;

odd_one_out('abc', 'xyz', 'tsu');
odd_one_out('rat', 'cab', 'dad');
odd_one_out('x', 'y', 'z');

sub odd_one_out {
   my @words = @_;
   print "Input: (" . join(",", @words) . ")\n";
   my @keep = ();
   foreach my $word (@words) {
      push @keep, $word if is_sorted($word);
   }
   my $removed = scalar(@words) - scalar(@keep);
   print "Output: $removed\n";
}

# a word is sorted if it is the same after sorting
# all of its characters, so we split each word into
# its characters, sort them, and join them back into
# a word again
sub is_sorted {
   my $word = shift;
   my $sorted_word = join("", sort(split //, $word));
   return $word eq $sorted_word;
}

