#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Algorithm::Combinatorics qw(combinations);
use Array::Compare;
use List::Util qw(min max);

my @deck;
foreach my $suit (0..3) {
  foreach my $rank (1..13) {
    push @deck,[$rank, $suit];
  }
}

my $comp = Array::Compare->new;

my %hands;
my $ip = combinations(\@deck, 5);
while (my $hand = $ip->next) {
  my $bin = 0;
  my @ranks = sort {$a <=> $b} map {$_->[0]} @{$hand};
  my %ranksc;
  foreach my $r (@ranks) {
    $ranksc{$r}++;
  }
  my @ranksk = sort {$b <=> $a} values %ranksc;
  my @suits = sort {$a <=> $b} map {$_->[1]} @{$hand};
  my %suitsc;
  foreach my $r (@suits) {
    $suitsc{$r}++;
  }
  my @suitsk = sort {$b <=> $a} values %suitsc;
  # Can't generate 5 of a kind.
  # Royal flush
  if (scalar keys %suitsc == 1 &&
      $comp->compare(\@ranks, [1, 10, 11, 12, 13])) {
    $bin = 2;
  }
  # Straight flush
  if ($bin == 0 &&
      scalar keys %suitsc == 1 &&
      min(@ranks) + 4 == max(@ranks)) {
    $bin = 2;
  }
  # Four of a kind
  if ($bin == 0 &&
      $ranksk[0] == 4) {
    $bin = 3;
  }
  # Full house
  if ($bin == 0 &&
      $ranksk[0] == 3 &&
      $ranksk[1] == 2) {
    $bin = 4;
  }
  # Flush
  if ($bin == 0 &&
      $suitsk[0] == 5) {
    $bin = 5;
  }
  # Straight
  if ($bin == 0 &&
      # match full rank struct
      (
        ($ranks[0] + 1 == $ranks[1] &&
         $ranks[1] + 1 == $ranks[2] &&
         $ranks[2] + 1 == $ranks[3] &&
         $ranks[3] + 1 == $ranks[4])
        ||
        $comp->compare(\@ranks, [1, 10, 11, 12, 13])
          )) {
    $bin = 6;
  }
  # Three of a kind
  if ($bin == 0 &&
      $ranksk[0] == 3) {
    $bin = 7;
  }
  # Two pair
  if ($bin == 0 &&
      $ranksk[0] == 2 && $ranksk[1] == 2) {
    $bin = 8;
  }
  # One pair
  if ($bin == 0 &&
      $ranksk[0] == 2) {
    $bin = 9;
  }
  # Anything else is High card
  if ($bin == 0) {
    $bin = 10;
  }
  $hands{$bin}++;
}
my $tot = 0;
foreach my $k (sort {$a <=> $b} keys %hands) {
  print "$k ".$hands{$k}."\n";
  $tot += $hands{$k};
}
print "total $tot\n";
