#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    { in => "Cooking with 5 ingredients!", out => "#cookingWithIngredients", },
    { in => "the-last-of-the-mohicans", out => "#thelastofthemohicans", },
    { in => "  extra spaces here", out => "#extraSpacesHere", },
    { in => "iPhone 15 Pro Max Review", out => "#iphoneProMaxReview", },
    { in => "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!", out => "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn", },
);

is valid_tag($_->{in}), $_->{out} foreach @examples;

done_testing;

sub valid_tag {
    my ($caption) = @_;

    my @chunks = split ' ', $caption;
    my @words  = grep { length } map { s/[^a-zA-Z]//gr } @chunks;

    return "" unless @words;

    my $tag = "#" . lc(shift @words) . join("", map { ucfirst lc } @words);
    return substr($tag, 0, 100);
}
