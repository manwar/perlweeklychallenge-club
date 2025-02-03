#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-307/#TASK2
#
# Find Anagrams
# =============
#
# You are given a list of words, @words.
#
# Write a script to find any two consecutive words and if they are anagrams,
# drop the first word and keep the second. You continue this until there is no
# more anagrams in the given list and return the count of final list.
#
## Example 1
##
## Input: @words = ("acca", "dog", "god", "perl", "repl")
## Output: 3
##
## Step 1: "dog" and "god" are anagrams, so dropping "dog" and keeping "god"
##         => ("acca", "god", "perl", "repl")
## Step 2: "perl" and "repl" are anagrams, so dropping "perl" and keeping "repl"
##         => ("acca", "god", "repl")
#
## Example 2
##
## Input: @words = ("abba", "baba", "aabb", "ab", "ab")
## Output: 2
##
## Step 1: "abba" and "baba" are anagrams, so dropping "abba" and keeping "baba"
##         => ("baba", "aabb", "ab", "ab")
## Step 2: "baba" and "aabb" are anagrams, so dropping "baba" and keeping "aabb"
##         => ("aabb", "ab", "ab")
## Step 3: "ab" and "ab" are anagrams, so dropping "ab" and keeping "ab"
##         => ("aabb", "ab")
#
############################################################
##
## discussion
##
############################################################
#
# As long as the length of the array keeps changing, check if two consecutive
# words are anagrams. If so, remove the first word and continue. Once the
# length of the array no longer changes, we can output the length.

use v5.36;

find_anagrams("acca", "dog", "god", "perl", "repl");
find_anagrams("abba", "baba", "aabb", "ab", "ab");

sub find_anagrams (@words) {
   say "Input: (" . join(", ", @words) . ")";
   my $len = scalar(@words);
   my $oldlen = 1 + $len;
   while($oldlen != $len) {
      my @tmp = ();
      foreach my $i (0..$#words) {
         if(is_anagram($words[$i], $words[$i+1])) {
            push @tmp, @words[$i+1..$#words];
            last;
         } else {
            push @tmp, $words[$i];
         }
      }
      @words = @tmp;
      $oldlen = $len;
      $len = scalar(@words);
   }
   say "Output: $len";
}

sub is_anagram($word1, $word2) {
   my $w1;
   my $w2;
   return 0 unless defined $word2;
   return 0 if length($word1) != length($word2);
   foreach my $c (split//,$word1) {
      $w1->{$c}++;
   }
   foreach my $c (split//,$word2) {
      $w2->{$c}++;
   }
   foreach my $c (keys %$w1) {
      return 0 if $w1->{$c} != $w2->{$c};
   }
   return 1;
}
