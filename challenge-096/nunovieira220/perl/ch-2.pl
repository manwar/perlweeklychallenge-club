#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
use List::Util qw[max];

# Input
my $S1 = "kitten";
my $S2 = "sitting";

# Edit Distance
my $maxLength = max(length($S1), length($S2));

for(my $i = 0; $i < $maxLength; $i++) {
  my $char1 = substr($S1, $i, 1);
  my $char2 = substr($S2, $i, 1);

  if(notEmpty($char1) && notEmpty($char2)) {
    say("Replace '$char1' with '$char2'");
  } elsif (notEmpty($char1)) {
    say("Remove '$char1' at position ".($i + 1));
  } else {
    say("Insert '$char2' at the end");
  }
}

sub notEmpty { return defined $_[0] && !$_[0] eq '' ? 1 : 0 }
