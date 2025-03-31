#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-315/#TASK1
#
# Task 1: Find Words
# ==================
#
# You are given a list of words and a character.
#
# Write a script to return the index of word in the list where you find the
# given character.
#
## Example 1
##
## Input: @list = ("the", "weekly", "challenge")
##        $char = "e"
## Output: (0, 1, 2)
#
#
## Example 2
##
## Input: @list = ("perl", "raku", "python")
##        $char = "p"
## Output: (0, 2)
#
#
## Example 3
##
## Input: @list = ("abc", "def", "bbb", "bcd")
##        $char = "b"
## Output: (0, 2, 3)
#
############################################################
##
## discussion
##
############################################################
#
# This one is straight forward: For each word, check if the character
# is in it, at keep the index in case the character is found.

use v5.36;

find_words( ["the", "weekly", "challenge"], "e");
find_words( ["perl", "raku", "python"], "p");
find_words( ["abc", "def", "bbb", "bcd"], "b");

sub find_words( $list, $char ) {
    say "Input: \@list = (" . join("\", \"", @$list) . ", \$char = '$char'";
    my @list = @$list;
    my @result = ();
    foreach my $i (0..$#list) {
        push @result, $i if $list[$i] =~ m/$char/;
    }
    say "Output: (" . join(", ", @result) . ")";
}
