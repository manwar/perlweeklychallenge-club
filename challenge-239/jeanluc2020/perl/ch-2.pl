#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-239/#TASK2
#
# Task 2: Consistent Strings
# ==========================
#
# You are given an array of strings and allowed string having distinct
# characters.
#
## A string is consistent if all characters in the string appear in the string
## allowed.
#
# Write a script to return the number of consistent strings in the given array.
#
## Example 1
##
## Input: @str = ("ad", "bd", "aaab", "baa", "badab")
##        $allowed = "ab"
## Output: 2
##
## Strings "aaab" and "baa" are consistent since they only contain characters 'a' and 'b'.
#
## Example 2
##
## Input: @str = ("a", "b", "c", "ab", "ac", "bc", "abc")
##        $allowed = "abc"
## Output: 7
#
## Example 3
##
## Input: @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d")
##        $allowed = "cad"
## Output: 4
##
## Strings "cc", "acd", "ac", and "d" are consistent.
#
############################################################
##
## discussion
##
############################################################
#
# Create a hash table that uses the characters of $allowed as
# the keys. Then for each string in the array, check all the
# characters. If one of those isn't in the hash table, the
# string is not consistent, so we don't count the string.
# Otherwise, count the string as consistent.
#
use strict;
use warnings;

consistent_strings( ["ad", "bd", "aaab", "baa", "badab"], "ab");
consistent_strings( ["a", "b", "c", "ab", "ac", "bc", "abc"], "abc");
consistent_strings( ["cc", "acd", "b", "ba", "bac", "bad", "ac", "d"], "cad");

sub consistent_strings {
   my ($str, $allowed) = @_;
   print "Input: \@str = (\"" . join("\", \"", @$str) . "\"), \$allowed = \"$allowed\"\n";
   my %allowed_chars = map { $_ => 1, } split //, $allowed;
   my $count = 0;
   foreach my $string (@$str) {
      my @chars = split //, $string;
      my $consistent = 1;
      foreach my $char (@chars) {
         unless($allowed_chars{$char}) {
            $consistent = 0;
            last;
         }
      }
      $count++ if $consistent;
   }
   print "Output: $count\n";
}

