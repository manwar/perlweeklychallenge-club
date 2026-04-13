sub f {
    pop
    =~ s/^\s+//r
    =~ s/./\l$&/gr
    =~ s/[^ a-z]//gir
    =~ s/ +(.)/\u$1/gr
    =~ s/^.{99}\K.*//r
    =~ s/^/#/r
}

printf "%s: %s\nwant: %s\ngot:  %s\n\n",
    $$_{name},
    f( $$_{input} ) eq $$_{output} ? "ok" : "ERROR",
    $$_{output},
    f( $$_{input} )
for
{ name   => 'Example 1',
  input  => 'Cooking with 5 ingredients!',
  output => '#cookingWithIngredients' },

{ name   => 'Example 2',
  input  => 'the-last-of-the-mohicans',
  output => '#thelastofthemohicans' },

{ name   => 'Example 3',
  input  => '  extra spaces here',
  output => '#extraSpacesHere' },

{ name   => 'Example 4',
  input  => 'iPhone 15 Pro Max Review',
  output => '#iphoneProMaxReview' },

{ name   => 'Example 5',
  input  => 'Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!',
  output => '#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn' };

# https://theweeklychallenge.org/blog/perl-weekly-challenge-369/
