#!/usr/bin/env perl

# You are given a given a string caption for a video.

# Write a script to generate tag for the given string caption in three
# steps as mentioned below:

# 1. Format as camelCase Starting with a lower-case letter and
#    capitalising the first letter of each subsequent word. Merge all
#    words in the caption into a single string starting with a #.
# 2. Sanitise the String Strip out all characters that are not English
#    letters (a-z or A-Z).
# 3. Enforce Length If the resulting string exceeds 100 characters,
#    truncate it so it is exactly 100 characters long.

use 5.018;
use strict;
use warnings;
use Test2::V0;

plan tests => 5;

sub valid_tag {
    my $str    = shift;
    my $result = q{};
    printf qq{ Input: \$caption = "%s"\n }, $str;

    $str =~ tr[a-zA-Z ][]cd;
    $str =~ tr[A-Z][a-z];

    $result .= join '', map { ucfirst $_ } split " ", $str;
    $result = q{#} . lcfirst $result;
    $result = substr( $result, 0, 100, q{} );

    printf qq{Output: %s\n}, $result;
    return $result;
}

my @examples = (
    {      in   => "Cooking with 5 ingredients!",
           out  => "#cookingWithIngredients",
           name => 'example 1'
    },
    {      in   => "the-last-of-the-mohicans",
           out  => "#thelastofthemohicans",
           name => 'example 2'
    },
    {      in   => "  extra spaces here",
           out  => "#extraSpacesHere",
           name => 'example 3'
    },
    {      in   => "iPhone 15 Pro Max Review",
           out  => "#iphoneProMaxReview",
           name => 'example 4'
    },
    {   in =>
            "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!",
        out =>
            "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn",
        name => 'example 5'
    },
);

is( valid_tag( $_->{ in } ), $_->{ out }, $_->{ name } )
    for @examples;
