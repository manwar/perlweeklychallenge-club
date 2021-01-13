#!/usr/bin/perl

# Perl Weekly Challenge - 077
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/
#
# Task 2 - Lonely X
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(sum);

# Prototypes
sub findLonelyXs (\@\@);
sub isLonelyX (\@$$$$);
sub printGrid ($\@);

# Input grid
my $g = [
  [qw(0 0 x 0)],
  [qw(x 0 0 0)],
  [qw(x 0 0 x)],
  [qw(0 x 0 0)],
];


sub findLonelyXs (\@\@) {
  my ($arG, $arGC) = @_;

  my $n = 0;
  my $w = scalar @{$arG->[0]};
  my $h = scalar @$arG;

  for my $y (0 .. $h - 1) {
    for my $x (0 .. $w - 1) {
      my $res = isLonelyX(@$arG, $w, $h, $x, $y);
      $n += $res;
      $arGC->[$x][$y] = ($res ? '*' : $arG->[$x][$y]);
    }
  }

  return $n;
}


sub isLonelyX (\@$$$$) {
  my ($arG, $w, $h, $x, $y) = @_;

  return 0 if ($arG->[$x][$y] ne 'x');

  my @rowIdx = (($x-1 < 0 ? 0 : $x-1) .. ($x+1 > $w-1 ? $w-1 : $x+1));
  my @colIdx = (($y-1 < 0 ? 0 : $y-1) .. ($y+1 > $h-1 ? $h-1 : $y+1));
  my @check;

  for my $row (@rowIdx) {
    for my $col (@colIdx) {
      push(@check, $arG->[$row][$col]);
    }
  }

  return (scalar(grep { $_ eq 'x' }  @check) == 1);
}


sub printGrid ($\@) {
  my ($title, $arG) = @_;

  print "$title:\n";
  for my $x (0 .. scalar @$arG - 1) {
    printf "[ %s ]\n", join(' ', @{$arG->[$x]});
  }
  print "\n";
}


my $gLonely = []; 

printGrid('Input', @$g);
my $n = findLonelyXs(@$g, @$gLonely);
printGrid('Output', @$gLonely);

printf "%d lonely X's found (marked '*')\n", $n;

