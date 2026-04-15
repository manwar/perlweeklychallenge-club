#! /usr/bin/raku

use Test;

plan 5;

is(validtag('Cooking with 5 ingredients!'), '#cookingWithIngredients', 'example 1');
is(validtag('the-last-of-the-mohicans'), '#thelastofthemohicans', 'example 2');
is(validtag('  extra spaces here'), '#extraSpacesHere', 'example 3');
is(validtag('iPhone 15 Pro Max Review'), '#iphoneProMaxReview', 'example 4');
is(validtag('Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!'), '#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn', 'example 5');

sub validtag($a) {
  my $p = '#';
  my $up = False;
  for $a.comb -> $c {
    if ($c ~~ /<[a..zA..Z]>/) {
      my $cc = $c;
      if ($up) {
        $cc = $cc.uc;
        $up = False;
      } else {
        $cc = $cc.lc;
      }
      $p ~= $cc;
    } elsif ($c eq ' ' && $p.chars > 1) {
      $up = True;
    }
  }
  if ($p.chars > 100) {
    substr-rw($p, 100) = '';
  }
  $p;
}
