#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub nearest_rgb{
  my @web_safe = (0,51,102,153,204,255);
  my ($r,$g,$b) = map hex,$_[0] =~ /#(..)(..)(..)/;
  my $safe = '#';
  foreach my $c($r,$g,$b) {
    my $best = 0;
    foreach my $s(@web_safe){
      $best = $s if abs($c - $s) < abs($best - $c)
    }
    $safe .= sprintf '%02X',$best
  }
  $safe
}

is nearest_rgb('#F4B2D1'),'#FF99CC','Example 1';
is nearest_rgb('#15E6E5'),'#00FFCC','Example 2';
is nearest_rgb('#191A65'),'#003366','Example 3';
is nearest_rgb('#2D5A1B'),'#336633','Example 4';
is nearest_rgb('#00FF66'),'#00FF66','Example 5';

done_testing();

