#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(max);

my $minlen=5;

my $y;
my @grid;
my @searchspaces;
open I,'<',$ARGV[0] or die "Can't open puzzle file\n";
while (<I>) {
  chomp;
  s/ +//g;
  $_=lc($_);
  if (defined $y) {
    if ($y != length($_)) {
      die "Not a rectangular grid\n";
    }
  } else {
    $y = length($_);
  }
  push @searchspaces,$_; # horizontal forward
  push @grid,[split '',$_];
  push @searchspaces,join('',reverse(@{$grid[-1]})); # horizontal backward
}
close I;
my $x=scalar @grid;

foreach my $i (0..$y-1) {
  my @q=map {$grid[$_][$i]} (0..$x-1);
  push @searchspaces,join('',@q); # vertical forward
  push @searchspaces,join('',reverse @q); # vertical backward
}

{
  # +x +y diagonals
  my $mxy=max($x,$y)-1;
  foreach my $xi (-$y+$minlen-1..$x-$minlen+1) {
    my @seq=map {[$xi+$_,$_]} grep {$xi+$_>=0 && $xi+$_<$x && $_<$y} (0..$mxy);
    if (scalar @seq >= $minlen) {
      my @q=map {$grid[$_->[0]][$_->[1]]} @seq;
      push @searchspaces,join('',@q);
      push @searchspaces,join('',reverse @q);
    }
  }
  # -x +y diagonals
  foreach my $xi (-$y+$minlen-1..$x-$minlen+1) {
    my @seq=map {[$xi+$_,$y-$_]} grep {$xi+$_>=0 && $y-$_>=0 && $xi+$_<$x} (1..$mxy);
    if (scalar @seq >= $minlen) {
      my @q=map {$grid[$_->[0]][$_->[1]]} @seq;
      push @searchspaces,join('',@q);
      push @searchspaces,join('',reverse @q);
    }
  }
}

my @found;
open I,'<',$ARGV[1] or die "Can't open wordlist file\n";
while (<I>) {
  chomp;
  if (length($_) >= $minlen) {
    my $w=lc($_);
    foreach my $ss (@searchspaces) {
      if (index($ss,$w) > -1) {
        push @found,$w;
        last;
      }
    }
  }
}
close I;

print join(', ',sort @found),"\n";
