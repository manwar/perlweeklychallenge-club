#! /usr/bin/perl

use strict;
use warnings;

my %o;

while (<>) {
  my $a=lc($_);
  $a =~ s/[^a-z]//g;
  map {$o{$_}++} split '',$a;
}

foreach my $k (sort keys %o) {
  print "$k: $o{$k}\n";
}
