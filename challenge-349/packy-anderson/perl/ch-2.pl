#!/usr/bin/env perl
use v5.40;

sub meetingPoint($path) {
  my ($x, $y) = (0, 0);
  foreach (split //, $path) {
    /U/ && do { $y++; };
    /D/ && do { $y--; };
    /R/ && do { $x++; };
    /L/ && do { $x--; };
    return 'true' if $x == 0 && $y == 0;
  }
  return 'false';
}

sub solution($path) {
  say qq/Input: \$path = "$path"/;
  say 'Output: ' . meetingPoint($path);
}

say "Example 1:";
solution("ULD");

say "\nExample 2:";
solution("ULDR");

say "\nExample 3:";
solution("UUURRRDDD");

say "\nExample 4:";
solution("UURRRDDLLL");

say "\nExample 5:";
solution("RRUULLDDRRUU");
