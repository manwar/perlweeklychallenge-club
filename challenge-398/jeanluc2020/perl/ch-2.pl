#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-398/#TASK2
#
# Task 2: String Difference
# =========================
#
# You are given an array of equal length strings.
#
# Write a script to find the difference integer array of each word in the given
# array. There will be one word with a different array; return that word.
#
###   Each words[i] can be converted into a difference integer array
###   difference[i] of length n - 1 where difference[i][j] = words[i][j+1] -
###   words[i][j]
#
## Example 1
##
## Input: @words = ("ab", "bc", "cd", "zy")
## Output: "zy"
##
## "ab" => [1 - 0] = [1]
## "bc" => [2 - 1] = [1]
## "cd" => [3 - 2] = [1]
## "zy" => [24 - 25] = [-1]
#
## Example 2
##
## Input: @words = ("cba", "fed", "azy")
## Output: "azy"
##
## "cba" => [1 - 2, 0 - 1] = [-1, -1]
## "fed" => [4 - 5, 3 - 4] = [-1, -1]
## "azy" => [25 - 0, 24 - 25] = [25, -1]
#
## Example 3
##
## Input: @words = ("pop", "ada", "beb", "cfc")
## Output: "pop"
##
## "pop" => [14 - 15, 15 - 14] = [-1, 1]
## "ada" => [3 - 0, 0 - 3] = [3, -3]
## "beb" => [4 - 1, 1 - 4] = [3, -3]
## "cfc" => [5 - 2, 2 - 5] = [3, -3]
#
## Example 4
##
## Input: @words = ("aaaa", "zzzz", "mmmm", "aaba")
## Output: "aaba"
##
## "aaaa" => [0 - 0, 0 - 0, 0 - 0] = [0, 0, 0]
## "zzzz" => [25 - 25, 25 - 25, 25 - 25] = [0, 0, 0]
## "mmmm" => [12 - 12, 12 - 12, 12 - 12] = [0, 0, 0]
## "aaba" => [0 - 0, 1 - 0, 0 - 1] = [0, 1, -1]
#
## Example 5
##
## Input: @words = ("aceg", "bdfh", "cegi", "azbz")
## Output: "azbz"
##
## "aceg" => [2 - 0, 4 - 2, 6 - 4] = [2, 2, 2]
## "bdfh" => [3 - 1, 5 - 3, 7 - 5] = [2, 2, 2]
## "cegi" => [4 - 2, 6 - 4, 8 - 6] = [2, 2, 2]
## "azbz" => [25 - 0, 1 - 25, 25 - 1] = [25, -24, 24]
#
############################################################
##
## discussion
##
############################################################
#
# First, we create all the difference integer arrays.
# Then, we compare the first two of them. If they are equal,
# we find the odd out out later in the array. If they are not
# equal, we compare the second one with the third one. If those
# are the same, then the first one is the odd one out, otherwise
# the second one is the odd one out.

use v5.36;

sub string_difference(@words) {
    say "Input: (" . join(", ", map { "\"$_\""} @words) . ")";
    my $diff = {};
    foreach my $word (@words) {
        my @chars = split //, $word;
        my $values = [];
        foreach my $index (0..$#chars-1) {
            push @$values, (ord($chars[$index+1]) - ord($chars[$index]));
        }
        $diff->{$word} = $values;
    }
    if(array_equal($diff->{$words[0]}, $diff->{$words[1]})) {
        # find the odd one out later in @words
        foreach my $i (2..$#words) {
            return say "Output: $words[$i]"
                unless array_equal($diff->{$words[0]}, $diff->{$words[$i]});
        }
    } else {
        # if $words[1] eq $words[2], then $words[0] is the odd one out,
        # otherwise $words[1] is the odd one out
        if(array_equal($diff->{$words[1]}, $diff->{$words[2]})) {
            return say "Output: $words[0]";
        }
        return say "Output: $words[1]";
    }
}

sub array_equal($arr1, $arr2) {
    my @arr1 = @$arr1;
    my @arr2 = @$arr2;
    return 0 if scalar(@arr1) != scalar(@arr2);
    foreach my $i (0..$#arr1) {
        return 0 if $arr1[$i] != $arr2[$i];
    }
    return 1;
}


string_difference("ab", "bc", "cd", "zy");
string_difference("cba", "fed", "azy");
string_difference("pop", "ada", "beb", "cfc");
string_difference("aaaa", "zzzz", "mmmm", "aaba");
string_difference("aceg", "bdfh", "cegi", "azbz");
