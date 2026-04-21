#!/usr/bin/env perl
#
=head1 Task 1: Valid Tag

Submitted by: Mohammad Sajid Anwar

You are given a given a string caption for a video.  Write a script to generate
tag for the given string caption in three steps as mentioned below:

    1. Format as camelCase
        Starting with a lower-case letter and capitalising the first letter of each
        subsequent word.  Merge all words in the caption into a single string starting
        with a #.
    2. Sanitise the String
        Strip out all characters that are not English letters (a-z or A-Z).
    3. Enforce Length
        If the resulting string exceeds 100 characters, truncate it so it is
        exactly 100 characters long.

=head2 Example 1

    Input: $caption = "Cooking with 5 ingredients!"
    Output: "#cookingWithIngredients"

=head2 Example 2

    Input: $caption = "the-last-of-the-mohicans"
    Output: "#thelastofthemohicans"

=head2 Example 3

    Input: $caption = "  extra spaces here"
    Output: "#extraSpacesHere"

=head2 Example 4

    Input: $caption = "iPhone 15 Pro Max Review"
    Output: "#iphoneProMaxReview"

=head2 Example 5

    Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
    Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["Cooking with 5 ingredients!", "#cookingWithIngredients", 'Example 1'],
    ["the-last-of-the-mohicans",    "#thelastofthemohicans",   'Example 2'],
    ["  extra spaces here",         "#extraSpacesHere",        'Example 3'],
    ["iPhone 15 Pro Max Review",    "#iphoneProMaxReview",     'Example 4'],
    ["Ultimate 24-Hour Challenge: Living in a Smart Home " .
     "controlled entirely by Artificial Intelligence and " .
     "Voice Commands in the year 2026!",
     "#ultimateHourChallengeLivingInASmartHomeControlled" .
     "EntirelyByArtificialIntelligenceAndVoiceCommandsIn",     'Example 5'],
];

sub valid_tag
{
   my $caption = shift;

    $caption =~ s/[^a-zA-Z\s]//g;
    my @words = split /\s+/, $caption;
    shift @words if $words[0] eq '';
    my $tag = '#' . lc shift @words;
    foreach my $word (@words) {
        $tag .= ucfirst lc $word;
    }
    return substr($tag, 0, 100);
}

for (@$cases) {
    is(valid_tag($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
