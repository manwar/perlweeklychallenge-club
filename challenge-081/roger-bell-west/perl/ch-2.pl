#! /usr/bin/perl

use strict;
use warnings;

my %c;
while (<>) {
  chomp;
  s/(--|'s)/ /g;
  s/[."(),]+/ /g;
  map {$c{$_}++} split ' ',$_;
}

my %f;
map {push @{$f{$c{$_}}},$_} sort keys %c;

foreach my $n (sort keys %f) {
  print join(' ',$n,@{%f{$n}}),"\n\n";
}
