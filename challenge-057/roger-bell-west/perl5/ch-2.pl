#! /usr/bin/perl

use strict;
use warnings;

my @input=qw(alphabet book carpet cadmium cadeau alpine);

my @out;
my %input=map {$_ => 1} @input;
my $len=1;
while (%input) {
  my %k;
  map {push @{$k{substr($_,0,$len)}},$_} keys %input;
  foreach my $k (keys %k) {
    if (scalar keys @{$k{$k}}==1) {
      push @out,$k;
      delete $input{$k{$k}[0]};
    }
  }
  $len++;
}

print map {"$_\n"} sort @out;
