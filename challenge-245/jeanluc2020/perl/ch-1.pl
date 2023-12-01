#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-245/#TASK1
#
# Task 1: Sort Language
# =====================
#
# You are given two array of languages and its popularity.
#
# Write a script to sort the language based on popularity.
# Example 1
#
# Input: @lang = ('perl', 'c', 'python')
#        @popularity = (2, 1, 3)
# Output: ('c', 'perl', 'python')
#
# Example 2
#
# Input: @lang = ('c++', 'haskell', 'java')
#        @popularity = (1, 3, 2)
# Output: ('c++', 'java', 'haskell')
#
############################################################
##
## discussion
##
############################################################
#
# The solution that jumps right into my face is to fill the data
# into a hash table, using lang as the key and popularity as the
# value. Then sort the keys by their values and put the result into
# the output.

use strict;
use warnings;

sort_language( ['perl', 'c', 'python'], [2, 1, 3] );
sort_language( ['c++', 'haskell', 'java'], [1, 3, 2] );

sub sort_language {
   my ($lang, $popularity) = @_;
   print "Input: (" . join(", ", @$lang) . ")\n       (" . join(", ", @$popularity) . ")\n";
   my $hash = {};
   my $index = 0;
   foreach my $elem (@$lang) {
      $hash->{$elem} = $popularity->[$index];
      $index++;
   }
   print "Output: (" . join(", ", sort { $hash->{$a} <=> $hash->{$b} } keys %$hash) . ")\n";
}

