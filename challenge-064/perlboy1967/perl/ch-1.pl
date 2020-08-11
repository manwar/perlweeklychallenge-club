#!/usr/bin/perl

# Perl Weekly Challenge - 064
#
# Task 1 - Minimum Sum Path
#
# Author: Niels 'PerlBoy' van Dijke

use strict;

use List::Util qw(min);
use Data::Dumper;

sub findMinSumPath($$\@\@);

my @msp;

my @matrix = ([qw(1 2 3)], [qw(4 5 6)], [qw(7 8 9)]);

print "Input:\n";
for my $x (0 .. 2) {
  print join("\t",@{$matrix[$x]})."\n";
}

my $minSumPath = findMinSumPath(0, 0, @matrix, @msp);

printf "\nMinimum Sum Path: %d\n", $minSumPath;
printf "Path: %s\n", join(' => ', @msp);


sub findMinSumPath ($$\@\@) {
  my ($x, $y, $arMatrix, $arMsp) = @_;

  my $return;

  my %mV;
  my $mP;

  if (defined $arMatrix->[$x+1]) {
    $mV{findMinSumPath($x+1, $y, @$arMatrix, @{$mP->{x}})} = 'x';
  }
  if (defined $arMatrix->[$x][$y+1]) {
    $mV{findMinSumPath($x, $y+1, @$arMatrix, @{$mP->{y}})} = 'y';
  }

  my $minV = min(keys %mV); 
  if ($minV) {
    @$arMsp = ($arMatrix->[$x][$y], @{$mP->{$mV{$minV}}});
    $return = $arMatrix->[$x][$y] + $minV;
  } else {
    @$arMsp = ($arMatrix->[$x][$y]);
    $return = $arMatrix->[$x][$y];
  }

  return $return;
}
