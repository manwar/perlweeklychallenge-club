#!/usr/bin/env perl
use v5.40;

sub isLight($coordinates) {
  my ($letter, $num) = split //, $coordinates;
  return (
    ( ($letter =~ /[aceg]/) && ($num % 2 == 0) )
    ||
    ( ($letter =~ /[bdfh]/) && ($num % 2 == 1) )
  ) ? 'true' : 'false';
}

sub solution($coordinates) {
  say qq/Input: \$coordinates = "$coordinates"/;
  say 'Output: ' . isLight($coordinates);
}

say "Example 1:";
solution("d3");

say "\nExample 2:";
solution("g5");

say "\nExample 3:";
solution("e6");
