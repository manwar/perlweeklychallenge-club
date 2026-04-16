#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
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

Example 1

Input: $caption = "Cooking with 5 ingredients!"
Output: "#cookingWithIngredients"

Example 2

Input: $caption = "the-last-of-the-mohicans"
Output: "#thelastofthemohicans"

Example 3
Input: $caption = "  extra spaces here"
Output: "#extraSpacesHere"

Example 4
Input: $caption = "iPhone 15 Pro Max Review"
Output: "#iphoneProMaxReview"

Example 5
Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"

=cut

use Test2::V0 -no_srand => 1;

is(valid_tag("Cooking with 5 ingredients!"), "#cookingWithIngredients", "Example 1");
is(valid_tag("the-last-of-the-mohicans"), "#thelastofthemohicans", "Example 2");
is(valid_tag("  extra spaces here"), "#extraSpacesHere", "Example 3");
is(valid_tag("iPhone 15 Pro Max Review"), "#iphoneProMaxReview", "Example 4");
is(valid_tag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"), "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn", "Example 5");

done_testing();

sub valid_tag
{
     my $caption = $_[0];
     $caption = lcfirst( join('', map { ucfirst } 
                         map { s/[^a-zA-Z]//g; lc($_) }
                         split(/\s/, $caption)) );
     $caption = substr('#' . $caption, 0, 100);
     return $caption;
}
