#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-352/#TASK1
#
# Task 1: Match String
# ====================
#
# You are given an array of strings.
#
# Write a script to return all strings that are a substring of another word in
# the given array in the order they occur.
#
## Example 1
##
## Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat")
## Output: ("cat", "dog", "dogcat", "rat")
#
#
## Example 2
##
## Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
## Output: ("hell", "world", "wor", "ellow")
#
#
## Example 3
##
## Input: @words = ("a", "aa", "aaa", "aaaa")
## Output: ("a", "aa", "aaa")
#
#
## Example 4
##
## Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
## Output: ("flow", "fl", "fli", "ig", "ght")
#
#
## Example 5
##
## Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
## Output: ("car", "pet", "enter", "pen", "pent")
#
############################################################
##
## discussion
##
############################################################
#
# We check each element in the list against each other element in the list.
# If it's a substring of the other word, we keep it and stop checking it
# against other words in the list. In order to avoid duplicates, we keep
# track of all the words we already saw and skip checking if we saw the word
# already earlier.

use v5.36;
match_string("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat");
match_string("hello", "hell", "world", "wor", "ellow", "elloworld");
match_string("a", "aa", "aaa", "aaaa");
match_string("flower", "flow", "flight", "fl", "fli", "ig", "ght");
match_string("car", "carpet", "carpenter", "pet", "enter", "pen", "pent");

sub match_string (@words) {
    say "Input: (\"" . join("\", \"", @words) . "\")";
    my @output = ();
    my $seen = {};
    OUTER: foreach my $i (0..$#words) {
        next if $seen->{$words[$i]};
        foreach my $j (0..$#words) {
            next if $i == $j;
            if($words[$j] =~ m/$words[$i]/) {
                push @output, $words[$i];
                $seen->{$words[$i]} = 1;
                next OUTER;
            }
        }
    }
    say "Output: (\"" . join("\", \"", @output) . "\")";
}

