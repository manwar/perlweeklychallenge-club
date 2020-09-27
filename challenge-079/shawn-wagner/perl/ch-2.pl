#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use open qw/:std :locale/;
use charnames qw/:full/;
use List::Util qw/min max/;

# Print histogram with fancy Unicode art.
sub histogram {
  my $highest = max @_;
  for my $row (reverse 1 .. $highest) {
    print "$row\N{BOX DRAWINGS LIGHT VERTICAL}";
    for my $col (@_) {
      printf "%s ", ($row <= $col ? "\N{FULL BLOCK}" : " ");
    }
    print "\n";
  }
  say " \N{BOX DRAWINGS LIGHT UP AND RIGHT}",
    "\N{BOX DRAWINGS LIGHT HORIZONTAL}\N{BOX DRAWINGS LIGHT HORIZONTAL}" x @_;
  say "  @_";
}

sub find_next_wall :prototype(\@$) {
  my ($N, $left) = @_;
  my $i = $left + 1;
  while ($N->[$i] < $N->[$left]) {
    $i += 1;
    if ($i >= @$N) {
      die "Out of range: $left, $i";
    }
  }
  return $i;
}

sub sum_area :prototype(\@$$) {
  my ($N, $left, $right) = @_;
  my $height = min @{$N}[$left, $right];
  my $area = 0;
  for (my $i = $left + 1; $i < $right; $i += 1) {
    $area += $height - $N->[$i];
  }
  return $area;
}

sub task2 {
  histogram @_;
  my $width = @_;
  my $area = 0;
  for (my $i = 0; $i < $#_; ) {
    my $left = $i;
    my $right = find_next_wall @_, $left;
    $area += sum_area @_, $left, $right;
    $i = $right;
  }
  say $area;
}

task2 2, 1, 4, 1, 2, 5;
print "\n";
task2 3, 1, 3, 1, 1, 5;
