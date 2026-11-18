#!/usr/bin/env raku
use v6;

sub largestInterval($int) {
  my @integers = (1 .. $int).grep(none /(.).*$0/);
  my %diffs;
  for 2 .. @integers.end -> $i {
    my ($prev, $cur) = (@integers[$i-1], @integers[$i]);
    my $d = $cur - $prev;
    push %diffs{$d}, "$prev and $cur";
  }
  my $largest = %diffs.keys.max: *.Int;
  return $largest, %diffs{$largest};
}

sub solution($int) {
  say "Input: \$int = $int";
  my ($interval, $list) = largestInterval($int);
  say "Output: $interval";
  say "\nBiggest jump between:";
  say " • " ~ $list.join("\n • ");
}

say "Example 1";
solution(20);

say "\nExample 2";
solution(110);

say "\nExample 3";
solution(500);

say "\nExample 4";
solution(2026);

say "\nExample 5";
solution(10000);
