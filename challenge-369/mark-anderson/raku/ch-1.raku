#!/usr/bin/env raku
use Test;

is valid-tag("Cooking with 5 ingredients!"), "#cookingWithIngredients";
is valid-tag("the-last-of-the-mohicans"), "#thelastofthemohicans";
is valid-tag("  extra spaces here"), "#extraSpacesHere";
is valid-tag("iPhone 15 Pro Max Review"), "#iphoneProMaxReview";
is valid-tag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"),
"#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn";

sub valid-tag($caption)
{
    given $caption.lc
    {
        S:g/<-[a..z\s]>//                andthen
        S:nth(2..*)/(<[a..z]>+)/{$0.tc}/ andthen
        S:g/\s+//                        andthen
        S/<</#/                          andthen
        S:c(100)/.*//                    
    }
}
