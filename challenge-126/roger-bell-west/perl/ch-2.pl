#! /usr/bin/perl

use strict;

use List::Util qw(min max);

my @in=(
  [qw(x * * * x * x x x x)],
  [qw(* * * * * * * * * x)],
  [qw(* * * * x * x * x *)],
  [qw(* * * x x * * * * *)],
  [qw(x * * * x * * * * x)],
    );

my $ymax=$#in;
my $xmax=$#{$in[0]};

my @mn;
foreach (0..$ymax) {
  push @mn,[(0) x ($xmax+1)];
}

foreach my $y (0..$ymax) {
  my @sy=(max(0,$y-1)..min($ymax,$y+1));
  foreach my $x (0..$xmax) {
    my @sx=(max(0,$x-1)..min($xmax,$x+1));
    if ($in[$y][$x] eq 'x') {
      foreach my $yi (@sy) {
        foreach my $xi (@sx) {
          if ($xi==$x && $yi==$y) {
            next;
          }
          $mn[$yi][$xi]++;
        }
      }
    }
  }
}

foreach my $y (0..$ymax) {
  foreach my $x (0..$xmax) {
    if ($in[$y][$x] eq 'x') {
      $mn[$y][$x]='x';
    }
  }
  print join(' ',@{$mn[$y]}),"\n";
}
