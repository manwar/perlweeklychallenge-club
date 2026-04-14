#!/usr/bin/perl
use strict;
use warnings;

sub valid_tag {
    my ($str) = lc shift;

    # turn everything non-letter into space (preserves word boundaries)
    $str =~ s/[^a-z]/ /g;

    die "Input contains no valid alphabetic characters" if $str !~ /[a-z]/;

    # remove leading and trailing spaces
    $str =~ s/^\s+|\s+$//g;

    # collapse multiple spaces
    $str =~ s/ +/ /g;

    # camelCase
    $str =~ s/ ([a-z])/uc($1)/ge;

    # remove spaces
    $str =~ s/ //g;

    # limit to 99 chars + '#'
    return '#' . substr($str, 0, 99);
}

# Tests
my $caption;

# Example 1
$caption = "Cooking with 5 ingredients!";
print valid_tag($caption), "\n"; # Output: "#cookingWithIngredients"

# Example 2
$caption = "the-last-of-the-mohicans";
print valid_tag($caption), "\n"; # Output: "#thelastofthemohicans"

# Example 3
$caption = "  extra spaces here";
print valid_tag($caption), "\n"; # Output: "#extraSpacesHere"

# Example 4
$caption = "iPhone 15 Pro Max Review";
print valid_tag($caption), "\n"; # Output: "#iphoneProMaxReview"

# Example 5
$caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!";
print valid_tag($caption), "\n"; # Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"
