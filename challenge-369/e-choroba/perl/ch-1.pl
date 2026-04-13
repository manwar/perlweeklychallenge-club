#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub valid_tag($caption) {
    substr
        '#' . lcfirst join("", map ucfirst lc,
                               split ' ', $caption =~ tr/ a-zA-Z//dcr),
        0, 100
}

use Test::More tests => 5;

is valid_tag('Cooking with 5 ingredients!'), '#cookingWithIngredients',
    'Example 1';
is valid_tag('the-last-of-the-mohicans'), '#thelastofthemohicans', 'Example 2';
is valid_tag('  extra spaces here'), '#extraSpacesHere', 'Example 3';

# Not sure why "p" in "iPhone" is lowercase, there's no such rule.
is valid_tag('iPhone 15 Pro Max Review'), '#iphoneProMaxReview', 'Example 4';

# Not sure why "H" in "Hour" is uppercase, if the whole 'word' is "24-Hour".
# If a dash is a valid word separator, why are there no uppercase letters in
# Example 2?
is valid_tag('Ultimate 24-Hour Challenge: Living in a Smart Home controlled'
             . ' entirely by Artificial Intelligence and Voice Commands in'
             . ' the year 2026!'),
    '#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificial'
        . 'IntelligenceAndVoiceCommandsIn',
    'Example 5';
