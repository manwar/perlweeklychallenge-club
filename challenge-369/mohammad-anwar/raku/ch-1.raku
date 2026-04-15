#!/usr/bin/env raku

use Test;

my @examples = (
    { in => "Cooking with 5 ingredients!", out => "#cookingWithIngredients", },
    { in => "the-last-of-the-mohicans",    out => "#thelastofthemohicans", },
    { in => "  extra spaces here",         out => "#extraSpacesHere", },
    { in => "iPhone 15 Pro Max Review",    out => "#iphoneProMaxReview", },
    { in => "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!", out => "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn", },
);

for @examples -> %ex {
    is valid-tag(%ex<in>), %ex<out>;
}

done-testing;

sub valid-tag($caption) {
    my @words = $caption.words.map({ .subst(/<-[a..zA..Z]>/, '', :g) }).grep(*.chars);

    return "" unless @words;

    my $tag = "#" ~ @words.shift.lc ~ @words.map({ .lc.tc }).join('');
    return $tag.substr(0, 100);
}
