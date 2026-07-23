#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-383/#TASK1
#
# Task 1: Similar List
# ====================
#
# You are given three list of strings.
#
# Write a script to find out if the first two list are similar with the help
# the third list. The third list contains the similar words map.
#
## Example 1
##
## Input: $list1 = ("great", "acting")
##        $list2 = ("fine", "drama")
##        $list3 = (["great", "fine"], ["acting", "drama"])
## Output: true
#
## Example 2
##
## Input: $list1 = ("apple", "pie")
##        $list2 = ("banana", "pie")
##        $list3 = (["apple", "peach"], ["peach", "banana"])
## Output: false
#
## Example 3
##
## Input: $list1 = ("perl4", "python")
##        $list2 = ("raku", "python")
##        $list3 = (["perl4", "perl5", "raku"])
## Output: true
#
## Example 4
##
## Input: $list1 = ("enjoy", "challenge")
##        $list2 = ("love", "weekly", "challenge")
##        $list3 = (["enjoy", "love"])
## Output: false
#
## Example 5
##
## Input: $list1 = ("fast", "car")
##        $list2 = ("quick", "vehicle")
##        $list3 = (["quick", "fast"], ["vehicle", "car"])
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# If both list1 and list2 have different lengths, they are not similar, so
# handle that case first. Then we return false for every index in the lists
# where the two values from the two lists don't map to similar words.
# In the end we know that for each index, the two elements map to similar
# words, so we can return true.

use v5.36;

sub similar_list($list1, $list2, $list3) {
    say "Input: list1 = (" . join(", ", @$list1) . "),";
    say "       list2 = (" . join(", ", @$list2) . "),";
    say "       list3 = (" . join(", ", map {"[" . join(", ", @{$_}) . "]"} @$list3) . ")";

    return say "Output: false" unless scalar(@$list1) == scalar(@$list2);
    my $last_index = scalar(@$list1) - 1;

    foreach my $i (0..$last_index) {
        return say "Output: false" unless maps_the_same($list1->[$i], $list2->[$i], $list3);
    }
    say "Output: true";
}

sub maps_the_same($elem1, $elem2, $list) {
    return 1 if $elem1 eq $elem2;
    foreach my $map (@$list) {
        my $hash = {};
        map { $hash->{$_} = 1, } @$map;
        return 1 if $hash->{$elem1} && $hash->{$elem2};
    }
    return 0;
}

similar_list(["great", "acting"], ["fine", "drama"], [["great", "fine"], ["acting", "drama"]]);
similar_list(["apple", "pie"], ["banana", "pie"], [["apple", "peach"], ["peach", "banana"]]);
similar_list(["perl4", "python"], ["raku", "python"], [["perl4", "perl5", "raku"]]);
similar_list(["enjoy", "challenge"], ["love", "weekly", "challenge"], [["enjoy", "love"]]);
similar_list(["fast", "car"], ["quick", "vehicle"], [["quick", "fast"], ["vehicle", "car"]]);

