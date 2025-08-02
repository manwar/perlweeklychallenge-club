#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-265/#TASK2
#
# Task 2: Completing Word
# =======================
#
# You are given a string, $str containing alphnumeric characters and array of
# strings (alphabetic characters only), @str.
#
# Write a script to find the shortest completing word. If none found return
# empty string.
#
## A completing word is a word that contains all the letters in the given
## string, ignoring space and number. If a letter appeared more than once in
## the given string then it must appear the same number or more in the word.
#
## Example 1
##
## Input: $str = 'aBc 11c'
##        @str = ('accbbb', 'abc', 'abbc')
## Output: 'accbbb'
##
## The given string contains following, ignoring case and number:
## a 1 times
## b 1 times
## c 2 times
##
## The only string in the given array that satisfies the condition is 'accbbb'.
#
## Example 2
##
## Input: $str = 'Da2 abc'
##        @str = ('abcm', 'baacd', 'abaadc')
## Output: 'baacd'
##
## The given string contains following, ignoring case and number:
## a 2 times
## b 1 times
## c 1 times
## d 1 times
##
## The are 2 strings in the given array that satisfies the condition:
## 'baacd' and 'abaadc'.
##
## Shortest of the two is 'baacd'
#
## Example 3
##
## Input: $str = 'JB 007'
##        @str = ('jj', 'bb', 'bjb')
## Output: 'bjb'
##
## The given string contains following, ignoring case and number:
## j 1 times
## b 1 times
##
## The only string in the given array that satisfies the condition is 'bjb'.
#
############################################################
##
## discussion
##
############################################################
#
# First, split $str into its characters, counting the occurences of each one.
# Then do the same for all elements of @str
# Walk through those elements ordered by length. If a word completes $str,
# we can stop processing since we already found the shortest one.

use strict;
use warnings;

completing_word('aBc 11c', ['accbbb', 'abc', 'abbc']);
completing_word('Da2 abc', ['abcm', 'baacd', 'abaadc']);
completing_word('JB 007', ['jj', 'bb', 'bjb']);
completing_word('FooBar', ['foo', 'bar', 'baz']);

sub completing_word {
   my $str = shift;
   my @str = @{$_[0]};
   print "Input: '$str'\n";
   print "       (" . join(", ", map { "'$_'" } @str) . ")\n";
   my $in_data;
   my $candidates = {};
   foreach my $c (split//, $str) {
      next unless $c =~ m/[a-zA-Z]/; # only use characters a-z in lower- and upper case
      $in_data->{ lc($c) }++;
   }
   foreach my $s (@str) {
      $candidates->{$s}->{len} = length($s);
      foreach my $c (split//, $s) {
         $candidates->{$s}->{chars}->{$c}++;
      }
   }
   my $found = 0;
   foreach my $candidate (sort { $candidates->{$a}->{len} <=> $candidates->{$b}->{len} } keys %$candidates) {
      my $possible = 1;
      foreach my $c (keys %$in_data) {
         $candidates->{$candidate}->{chars}->{$c} //= 0;
         $possible = 0 if $in_data->{$c} > $candidates->{$candidate}->{chars}->{$c};
      }
      if($possible) {
         $found = 1;
         print "Output: '$candidate'\n";
         last;
      }
   }
   print "Output: ''\n" unless $found;
}
