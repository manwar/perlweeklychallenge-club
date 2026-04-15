#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(validtag('Cooking with 5 ingredients!'), '#cookingWithIngredients', 'example 1');
is(validtag('the-last-of-the-mohicans'), '#thelastofthemohicans', 'example 2');
is(validtag('  extra spaces here'), '#extraSpacesHere', 'example 3');
is(validtag('iPhone 15 Pro Max Review'), '#iphoneProMaxReview', 'example 4');
is(validtag('Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!'), '#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn', 'example 5');

sub validtag($a) {
  my $p = '#';
  my $up = 0;
  foreach my $c (split '', $a) {
    if ($c =~ /[[:alpha:]]/) {
      my $cc = $c;
      if ($up) {
        $cc = uc($cc);
        $up = 0;
      } else {
        $cc = lc($cc);
      }
      $p .= $cc;
    } elsif ($c eq ' ' && length($p) > 1) {
      $up = 1;
    }
  }
  if (length($p) > 100) {
    substr($p, 100) = '';
  }
  $p;
}
