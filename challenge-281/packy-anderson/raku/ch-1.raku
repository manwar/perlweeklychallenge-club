#!/usr/bin/env raku
use v6;

sub isLight($coordinates) {
  my ($letter, $num) = $coordinates.comb;
  return (
    $letter.match(/<[aceg]>/) && ($num %% 2)
    ||
    $letter.match(/<[bdfh]>/) && !($num %% 2)
  ) ?? 'true' !! 'false';
}

sub solution($coordinates) {
  say qq/Input: \$coordinates = "$coordinates"/;
  say 'Output: ' ~ isLight($coordinates);
}

say "Example 1:";
solution("d3");

say "\nExample 2:";
solution("g5");

say "\nExample 3:";
solution("e6");
