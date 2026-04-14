#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-369#TASK1>

Author: Niels 'PerlBoy' van Dijke

Task 1: Valid Tag
Submitted by: Mohammad Sajid Anwar

You are given a given a string caption for a video.

Write a script to generate tag for the given string caption in three steps as mentioned below:

1. Format as camelCase
Starting with a lower-case letter and capitalising the first letter of each subsequent word.
Merge all words in the caption into a single string starting with a #.
2. Sanitise the String
Strip out all characters that are not English letters (a-z or A-Z).
3. Enforce Length
If the resulting string exceeds 100 characters, truncate it so it is
exactly 100 characters long.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

sub validTag ($input) {
  my @w = map { ucfirst } grep { length } split /\s+/, $input =~ s#[^a-zA-Z\s]##gr;
  return '#'.substr(join('',lc shift @w,@w),0,99)
}

is(validTag('Cooking with 5 ingredients!'),
            '#cookingWithIngredients','Example 1');
is(validTag('the-last-of-the-mohicans'),
            '#thelastofthemohicans','Example 2');
is(validTag('  extra spaces here'),
            '#extraSpacesHere','Example 3');
is(validTag('iPhone 15 Pro Max Review'),
            '#iphoneProMaxReview','Example 4');
is(validTag('Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely '.
            'by Artificial Intelligence and Voice Commands in the year 2026!'),
            '#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificial'.
            'IntelligenceAndVoiceCommandsIn','Example 5');

done_testing;
