#! /usr/bin/perl

use strict;
use warnings;

my @l=(2,6,1,3);

print join(' ',noble(@l)),"\n";

sub noble {
  my @l=sort @_;
  my @r;
  foreach my $m (0..$#l) {
    if ($l[$m] == $#l-$m) {
      push @r,$l[$m];
    }
  }
  return @r;
}
