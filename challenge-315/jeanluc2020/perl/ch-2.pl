#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-315/#TASK2
#
# Task 2: Find Third
# ==================
#
# You are given a sentence and two words.
#
# Write a script to return all words in the given sentence that appear in
# sequence to the given two words.
#
## Example 1
##
## Input: $sentence = "Perl is a my favourite language but Python is my favourite too."
##        $first = "my"
##        $second = "favourite"
## Output: ("language", "too")
#
#
## Example 2
##
## Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
##        $first = "a"
##        $second = "beautiful"
## Output: ("doll", "princess")
#
#
## Example 3
##
## Input: $sentence = "we will we will rock you rock you.",
##        $first = "we"
##        $second = "will"
## Output: ("we", "rock")
#
############################################################
##
## discussion
##
############################################################
#
# Remove punctuation from the sentence, then split it into words.
# Now for each index, if the word at the index matches $first and
# the word after it matches $second, then the word after that will
# be added to the result array.

use v5.36;

find_third("Perl is a my favourite language but Python is my favourite too.", "my", "favourite");
find_third("Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful");
find_third("we will we will rock you rock you.", "we", "will");

sub find_third($sentence, $first, $second) {
    say "Input: \$sentence = \"$sentence\"";
    say "       \$first    = \"$first\"";
    say "       \$second   = \"$second\"";
    my @output = ();
    $sentence =~ s/[,\?\.!]//g; # remove punctuation
    my @sentence = split /\s+/, $sentence;
    foreach my $i (0..$#sentence) {
        if($sentence[$i] eq $first and defined($sentence[$i+1]) and $sentence[$i+1] eq $second) {
            push @output, $sentence[$i+2] if defined($sentence[$i+2]);
        }
    }
    if(@output) {
        say "Output: (\"" . join("\", \"", @output) . "\")";
    } else {
        say "Output: ()";
    }
}
