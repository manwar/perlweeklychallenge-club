#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-369/#TASK1
#
# Task 1: Valid Tag
# =================
#
# You are given a given a string caption for a video.
#
# Write a script to generate tag for the given string caption in three steps as
# mentioned below:
#
# 1. Format as camelCase
# Starting with a lower-case letter and capitalising the first letter of each
# subsequent word. Merge all words in the caption into a single string
# starting with a #.
# 2. Sanitise the String
# Strip out all characters that are not English letters (a-z or A-Z).
# 3. Enforce Length
# If the resulting string exceeds 100 characters, truncate it so it is
# exactly 100 characters long.
#
## Example 1
##
## Input: $caption = "Cooking with 5 ingredients!"
## Output: "#cookingWithIngredients"
#
## Example 2
##
## Input: $caption = "the-last-of-the-mohicans"
## Output: "#thelastofthemohicans"
#
## Example 3
##
## Input: $caption = "  extra spaces here"
## Output: "#extraSpacesHere"
#
## Example 4
##
## Input: $caption = "iPhone 15 Pro Max Review"
## Output: "#iphoneProMaxReview"
#
## Example 5
##
## Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
## Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"
#
############################################################
##
## discussion
##
############################################################
#
# After removing any non-word characters before the first a-z/A-Z, we just need
# to split $caption into individual words, lowercase each one, and uppercase
# the first character starting at the second word. In the end, we prepend a
# single "#" and limit the length to 99 characters from the result string we
# created before that.

use v5.36;

valid_tag("Cooking with 5 ingredients!");
valid_tag("the-last-of-the-mohicans");
valid_tag("  extra spaces here");
valid_tag("iPhone 15 Pro Max Review");
valid_tag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!");

sub valid_tag($caption) {
    say "Input: \"$caption\"";
    $caption =~ s/^[^A-Za-z]+//;
    my @words = split /\s+/, $caption;
    my $result = shift @words;
    $result =~ s/[^a-zA-Z]//g;
    $result = lc($result);
    foreach my $word (@words) {
        $word =~ s/[^a-zA-Z]//g;
        $word = lc($word);
        $word =~ s/^[a-z]/uc($&)/e;
        $result .= $word;
    }
    $result = "#" . substr($result,0,99);
    say "Output: \"$result\"";
}
