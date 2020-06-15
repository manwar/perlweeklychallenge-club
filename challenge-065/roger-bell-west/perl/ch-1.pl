#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(min);

my $N = 2;
my $S = 4;

my @out;

my @l;

do {
  my $n=[0];
  if (@l) {
    $n=shift @l;
  }
  my $s=pop @{$n};
  if (scalar @{$n} == $N-1) {
    my $digit=$S-$s;
    if ($digit>=0 && $digit<=9) {
      push @out,join('',@{$n},$digit);
    }
  } else {
    foreach my $digit (($s==0?1:0)..min($S-$s,9)) {
      push @l,[@{$n},$digit,$s+$digit];
    }
  }
} while (@l);

print join(', ',sort @out),"\n";
