#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;

# Input
open(my $fh, "<", dirname(__FILE__)."/input.txt") or die "Can't open < input.txt: $!";

my %sums = ();
my %freqs = ();

# Get word frenquencies from file
while(<$fh>) {
  chomp;
  s/--/ /g;
  my @words = split(/ /, $_);

  for(@words) {
    $_ =~ s/\.|"|'s|,|\(|\)//g;
    $sums{$_} = $sums{$_} ? $sums{$_} + 1 : 1;
  }
}

# Join words by frequency
for(sort keys %sums) {
  $freqs{$sums{$_}} = () if(!$freqs{$sums{$_}});

  push @{$freqs{$sums{$_}}}, $_;
}

# Output
for(sort keys %freqs) {
  my $res = join(', ', @{$freqs{$_}});
  print $_.": ".$res."\n";
}