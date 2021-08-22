#!/usr/bin/perl

# Perl Weekly Challenge - 126
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-126/#TASK2
#
# Task 2 - Minesweeper Game
#
# Author: Niels 'PerlBoy' van Dijke

use v5.16;
use strict;
use warnings;

# Prototype(s)
sub generateBoard($$\@);
sub printBoard(\@);
sub solveBoard(\@);

my @B;

@ARGV = (8,8) unless scalar @ARGV;

generateBoard(shift,shift,@B);
printBoard(@B);
solveBoard(@B);
printBoard(@B);


sub generateBoard($$\@) {
  my ($w,$h,$arB) = @_;

  my @c = qw(X . . . .); # 1 in 5 chance of placing a bomb

  foreach my $y (1 .. $h) {
    foreach my $x (1 .. $w) {
      $arB->[$y][$x] = $c[int rand(scalar @c)];
    }
    $arB->[$y+1] = [];
  }
}

sub printBoard(\@) {
  my ($arB) = @_;

  print " ----[Board]----\n";
  foreach my $y (1 .. scalar(@$arB)-2) {
    printf "%s\n", join(' ',map{$_//''} @{$arB->[$y]});
  }
  print " ---------------\n";
}

sub solveBoard(\@) {
  my ($arB) = @_;

  foreach my $y (1 .. scalar(@$arB)-2) {
    foreach my $x (1 .. scalar(@{$arB->[1]})-1) {
      next if $arB->[$y][$x] eq 'X';
      my $n = scalar grep /X/,
        $arB->[$y-1][$x-1] // '', # NW
        $arB->[$y-1][$x]   // '', # N
        $arB->[$y-1][$x+1] // '', # NE
        $arB->[$y][$x-1]   // '', # W
        $arB->[$y][$x+1]   // '', # E
        $arB->[$y+1][$x-1] // '', # SW
        $arB->[$y+1][$x]   // '', # S
        $arB->[$y+1][$x+1] // ''; # SE
      $arB->[$y][$x] = ($n == 0 ? '.' : $n);
    }
  }
}

