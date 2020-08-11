#! /usr/bin/perl

use strict;
use warnings;

my %ev;

open I,'<','data1';
while (<I>) {
  chomp;
  my @e=$_ =~ /(IN|OUT): (\d+):(\d+)/g;
  while (@e) {
    my $delta=(shift @e eq 'IN')?1:-1;
    my $t=(60*shift @e)+shift @e;
    $ev{$t}+=$delta;
  }
}

my $ontime=0;
my $occ=0;
my $laston=0;
foreach my $t (sort {$a <=> $b} keys %ev) {
  my $lastocc=$occ;
  $occ+=$ev{$t};
  if ($lastocc==0 && $occ>0) {
    $laston=$t;
  } elsif ($lastocc>0 && $occ==0) {
    $ontime+=($t-$laston);
  }
}

print "$ontime\n";
