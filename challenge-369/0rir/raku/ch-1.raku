#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅∪∩∋∈∉⊆ ≡ ≢ «␤ » ∴ 🐧
use v6.d;
use Test;

=begin comment
May be edited for space.
369-1: Valid Tag   Submitted by: Mohammad Sajid Anwar
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
￼
=end comment

my @Test =
    # in    /  exp
    "Cooking with 5 ingredients!",
        "#cookingWithIngredients",
    "the-last-of-the-mohicans",
        "#thelastofthemohicans",
    "  extra spaces here",
        "#extraSpacesHere",
    "iPhone 15 Pro Max Review",
        "#iphoneProMaxReview",
    "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!",
    "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn",
    "i#P!h\$o%n-e 1 7 9 5 (P)_r-o - M]a[x Review",
        "#iphoneProMaxReview",
    '',
        '#',
;
plan +@Test ÷ 2;

constant \MAX-LENGTH = 100 -1;

my regex reject{ <-[a..z A..Z \s ]>+ }

sub task( Str:D $_ is copy -->Str:D) {

    .=trim-leading;                 #
    s:g/<reject>+//;                # just letters and whitespace
    .=lc;
     s:g/ \s+ (<[a..z]>) /{$0.uc}/; # connect words w/ camelcase
     .=substr(0,MAX-LENGTH);
     '#' ~ $_
}

for @Test -> $in, $exp {
    is task( $in), $exp, "{$exp // $exp.^name()} <- $in.raku()";
}
done-testing;

my $caption = "iPhone 15 Pro Max Review";
say qq{\nInput: \$caption = "$caption"\nOutput: "}, task($caption), '"';
