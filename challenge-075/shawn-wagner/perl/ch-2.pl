#!/usr/bin/env perl
use warnings;
use strict;
use utf8;
use open qw/:std encoding(UTF-8)/;
use feature qw/say/;
use List::Util qw/max/;

# Fancy unicode histogram printer
sub histogram {
  my @A = @_;
  my $rows = max @A;
  for my $row (reverse (1 .. $rows)) {
    print $row, "│";
    for my $col (@A) {
      print $col >= $row ? "█" : " ", " ";
    }
    print "\n";
  }
  print " └", "──" x @A, "\n  ";
  print $_, " " for @A;
  print "\n";
}

sub task2 {
  my @A = @_;
  histogram @A;
  my $maxsize = 0;
  for my $left (0 .. $#A) {
    for my $top (1 .. $A[$left]) {
      for my $right ($left+1 .. $#A) {
        last if ($A[$right] < $top);
        my $size = ($right - $left + 1) * $top;
        $maxsize = max $maxsize, $size;
      }
    }
  }
  say "Largest rectangle area: $maxsize";
}

task2 2, 1, 4, 5, 3, 7;
print "\n";
task2 3, 2, 3, 5, 7, 5;
