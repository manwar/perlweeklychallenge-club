#! /usr/bin/perl

use strict;
use warnings;

my $ml=0;
my @r;
while (<>) {
  chomp;
  my $l=length($_);
  if ($l >= $ml) {
    if (join('',sort split '',$_) eq $_) {
      if ($l > $ml) {
        @r=();
        $ml=$l;
      }
      push @r,$_;
    }
  }
}

print map{"$_\n"} @r;
