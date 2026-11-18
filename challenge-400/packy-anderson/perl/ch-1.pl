#!/usr/bin/env perl
use v5.44;

STDOUT->binmode(":utf8"); # let me print unicode

use List::AllUtils qw( max_by );

sub largestInterval($int) {
  my @integers = grep {! /(.).*\1/ } (1 .. $int);
  my %diffs;
  for my $i ( 2 .. $#integers ) {
    my ($prev, $cur) = ($integers[$i-1], $integers[$i]);
    my $d = $cur - $prev;
    push @{$diffs{$d}}, "$prev and $cur";
  }
  my $largest = max_by { int($_) } keys %diffs;
  return $largest, $diffs{$largest};
}

sub solution($int) {
  say "Input: \$int = $int";
  my ($interval, $list) = largestInterval($int);
  say "Output: $interval";
  say "\nBiggest jump between:";
  say " \x{2022} " . join("\n \x{2022} ", @$list);
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