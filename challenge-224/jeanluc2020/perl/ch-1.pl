#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-224/#TASK1
#
# Task 1: Special Notes
# =====================
#
# You are given two strings, $source and $target.
#
# Write a script to find out if using the characters (only once) from source, a target string can be created.
#
## Example 1
##
## Input: $source = "abc"
##        $target = "xyz"
## Output: false
#
## Example 2
##
## Input: $source = "scriptinglanguage"
##        $target = "perl"
## Output: true
#
## Example 3
##
## Input: $source = "aabbcc"
##        $target = "abc"
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# We re-use the solution from the weekly challenge 221 task 1:
# https://theweeklychallenge.org/blog/perl-weekly-challenge-221/#TASK1
# Solution from
# http://gott-gehabt.de/800_wer_wir_sind/thomas/Homepage/Computer/perl/theweeklychallenge-221-1.html
# This has a function that returns the length of a good string in words - in
# our case, "words" is our first input, and the potential good string consists
# of our second input string.
# The actual solution is therefore trivial.

use strict;
use warnings;
use Data::Dumper;

special_notes("abc", "xyz");
special_notes("scriptinglanguage", "perl");
special_notes("aabbcc", "abc");

sub special_notes {
   my ($source, $target) = @_;
   print "Input: source: $source, target: $target\n";
   if(good_string_result($target, $source)) {
      print "Output: true\n";
      return "true";
   }
   print "Output: false\n";
   return "false";
}

sub good_string_result {
   my ($word, $chars) = @_;
   my ($wordmap, $charmap);
   my $result = 0;
   map { $wordmap->{$_}++ } split //, $word;
   map { $charmap->{$_}++ } split //, $chars;
   foreach my $c  (keys %$wordmap) {
      return 0 unless $charmap->{$c};
      return 0 unless $charmap->{$c} >= $wordmap->{$c};
      $result += $wordmap->{$c};
   }
   return $result;
}
