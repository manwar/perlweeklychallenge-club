#! /usr/bin/perl

use strict;
use warnings;

my @H = (2, 6, 4, 5, 1, 3); # Heights
my @T = (1, 0, 2, 0, 1, 2); # Number of taller people in front

my @i=sort {$H[$b] <=> $H[$a]} (0..$#H); # ordered by decreasing height
my @n;

foreach my $p (@i) {
  if ($T[$p]==0) {
    unshift @n,$p+1;
  } elsif ($T[$p] == scalar @n) {
    push @n,$p+1;
  } else {
    splice @n,$T[$p],0,$p+1;
  }
}

print join(', ',map {$H[$_-1]} @n),"\n";

foreach my $ti (0..$#n) {
  my $tx=$n[$ti]-1;
  my $mh=$H[$tx];
  my $hi=0;
  foreach my $tj (0..$ti-1) {
    if ($H[$n[$tj]-1] > $mh) {
      $hi++;
    }
  }
  unless ($hi == $T[$tx]) {
    die "index $ti failed\n";
  }
}
