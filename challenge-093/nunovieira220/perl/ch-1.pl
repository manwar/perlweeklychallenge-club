#!/usr/bin/perl

use strict;
use warnings;
use feature qw(say);
no autovivification;

# Input
my @coords = ([1, 1], [2, 2], [3, 1], [1, 3], [5, 3]);

# Max Points
my %points = ();
my $res = 1;

for (@coords) {
  my ($fst, $snd) = @{$_};

  if(!$points{$fst}{$snd}) {
    addPoint($fst, $snd);
    updateLinePoints($fst, $snd);
  }
}

print Dumper(\%points);

# Output
say ($res);

# Add new point
sub addPoint {
  my ($fst, $snd) = @_;
  update($fst, $snd, $fst + 1, $snd, 'r');
  update($fst, $snd, $fst, $snd + 1, 'u');
  update($fst, $snd, $fst + 1, $snd + 1, 'ru');
  update($fst, $snd, $fst + 1, $snd - 1, 'rd');
}

# Update line points
sub updateLinePoints {
  my ($fst, $snd) = @_;

  for(my $i = 1; isDefined($fst - $i, $snd, 'r'); $i++) {
    update($fst - $i, $snd, $fst - $i + 1, $snd, 'r');
  }

  for(my $i = 1; isDefined($fst, $snd - $i, 'u'); $i++) {
    update($fst, $snd - $i, $fst, $snd - $i + 1, 'u');
  }

  for(my $i = 1; isDefined($fst - $i, $snd - $i, 'ru'); $i++) {
    update($fst - $i, $snd - $i, $fst - $i + 1, $snd - $i + 1, 'ru');
  }

  for(my $i = 1; isDefined($fst - $i, $snd + $i, 'rd'); $i++) {
    update($fst - $i, $snd + $i, $fst - $i + 1, $snd + $i - 1, 'rd');
  }
}

# Test if defined
sub isDefined {
  my ($a, $b, $p) = @_;
  return (defined $points{$a}{$b}{$p} && $points{$a}{$b}{$p} > 0);
}

# Update value
sub update {
  my ($a, $b, $a1, $b1, $p) = @_;
  my $val = ($points{$a1}{$b1}{$p} || 0) + 1;
  $points{$a}{$b}{$p} = $val;
  $res = $val if($val > $res);
}