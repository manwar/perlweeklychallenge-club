#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Test::More;

=head1 NAME

ch-1.pl - Challenge 369 Task 1: Valid Tag

=head1 SYNOPSIS

The goal is to convert a video caption string into a sanitized social media tag.

1. Format as camelCase: Starting with a lower-case letter and capitalising the first letter of each subsequent word.
   Merge all words in the caption into a single string starting with a #.
2. Sanitise the String: Strip out all characters that are not English letters (a-z or A-Z).
3. Enforce Length: If the resulting string exceeds 100 characters, truncate it so it is exactly 100 characters long.

=head1 DESCRIPTION

Example 1: "Cooking with 5 ingredients!" -> "#cookingWithIngredients"
Example 2: "the-last-of-the-mohicans" -> "#thelastofthemohicans"
Example 3: "  extra spaces here" -> "#extraSpacesHere"
Example 4: "iPhone 15 Pro Max Review" -> "#iphoneProMaxReview"

=cut

sub generate_tag {
    my ($caption) = @_;

    # 1. Sanitise the String (keep only letters and spaces for now to help with camelCase)
    # The task says "Strip out all characters that are not English letters".
    # But if we strip them all immediately, we might lose word boundaries (like "5 ingredients").
    # Looking at the examples, "5 ingredients" becomes "WithIngredients" if "5" is stripped.
    # Actually, the logic seems to be:
    # a) Remove non-letters and non-whitespace.
    # b) Lowercase everything.
    # c) Convert to camelCase using remaining spaces.
    # d) Remove all remaining spaces.

    $caption =~ s/[^a-zA-Z\s]//g;
    $caption =~ s/^\s+//;
    $caption = lc($caption);

    # camelCase: space(s) followed by a letter becomes uppercase letter
    $caption =~ s/\s+([a-z])/\U$1/g;

    # Remove any remaining spaces (e.g. at the end)
    $caption =~ s/\s+//g;

    # Enforce Length: total length including # should be 100
    if (length($caption) > 99) {
        $caption = substr($caption, 0, 99);
    }

    return '#' . $caption;
}

# Unit Tests
is(generate_tag("Cooking with 5 ingredients!"), "#cookingWithIngredients", "Example 1");
is(generate_tag("the-last-of-the-mohicans"), "#thelastofthemohicans", "Example 2");
is(generate_tag("  extra spaces here"), "#extraSpacesHere", "Example 3");
is(generate_tag("iPhone 15 Pro Max Review"), "#iphoneProMaxReview", "Example 4");
is(generate_tag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"), "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn", "Example 5 (Length check)");
is(generate_tag("i#P!h\$o%n-e 1 7 9 5 (P)_r-o - M]a[x Review"), "#iphoneProMaxReview", "Example 6 (Complex sanitization)");
is(generate_tag(""), "#", "Empty string");

done_testing();
