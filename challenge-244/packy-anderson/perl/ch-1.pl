#!/usr/bin/env perl
use v5.38;

sub countSmaller {
  my @int = @_;
  my @counts;
  foreach my $i ( 0 .. $#int ) {
    $counts[$i] = 0;
    for my $j ( 0 .. $#int ) {
      $counts[$i]++ if $int[$j] < $int[$i];
    }
  }
  return @counts;
}

sub solution {
  my @int = @_;
  say 'Input: @arr = (' . join(', ', @int) . ')';
  my @output = countSmaller(@int);
  say 'Output: (' . join(', ', @output) . ')';
}

say "Example 1:";
solution(8, 1, 2, 2, 3);

say "\nExample 2:";
solution(6, 5, 4, 8);

say "\nExample 3:";
solution(2, 2, 2);
