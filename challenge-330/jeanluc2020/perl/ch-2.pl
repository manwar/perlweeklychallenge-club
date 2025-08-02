#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-330/#TASK2
#
# Task 2: Title Capital
# =====================
#
# You are given a string made up of one or more words separated by a single
# space.
#
# Write a script to capitalise the given title. If the word length is 1 or 2
# then convert the word to lowercase otherwise make the first character
# uppercase and remaining lowercase.
#
## Example 1
##
## Input: $str = "PERL IS gREAT"
## Output: "Perl is Great"
#
#
## Example 2
##
## Input: $str = "THE weekly challenge"
## Output: "The Weekly Challenge"
#
#
## Example 3
##
## Input: $str = "YoU ARE A stAR"
## Output: "You Are a Star"
#
############################################################
##
## discussion
##
############################################################
#
# We split the input into the individual words. Then we lowercase all words of
# a length <= 2. For the words longer than that, we uppercase the first
# character and lowercase the rest. In the end, we join the words together
# again to form the full sentence.

use v5.36;

title_capital("PERL IS gREAT");
title_capital("THE weekly challenge");
title_capital("YoU ARE A stAR");

sub title_capital($str) {
    say "Input: \"$str\"";
    my @output = ();
    my @words = split /\s+/, $str;
    foreach my $word (@words) {
        if(length($word) <= 2) {
            push @output, lc($word);
        } else {
            push @output, uc(substr($word,0,1)) . lc(substr($word,1));
        }
    }
    say "Output: " . join(" ", @output);
}
